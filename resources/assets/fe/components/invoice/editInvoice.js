import React, { Component } from 'react'
import Loading  from '../layout/loading'
import Api from '../../api'
import * as _ from 'lodash'
import Input from "../partial/input";
import { requestInvoice, requestGetList, receiveNewInvoice} from "../../actions/invoice";
import ClassNames from "classnames";

export default class EditInvoice extends Component{
    constructor(props) {
        super(props);
        this.state = {
            isFetching: true,
            errors: [],
            title: '',
            isInited: false,
            invoice: this.props.invoice,
        };
        this.errorMsg = 'Field is required';
        this.onSubmit = this.onSubmit.bind(this);
        this.onChangeValue = this.onChangeValue.bind(this);
    }

    componentWillMount(){
        this.props.dispatch(
            requestInvoice(this.props.jwt, this.props.match.params.id)
        );
    }

    componentWillReceiveProps(nextProps){
        if(!_.isEmpty(nextProps.invoice)){
            const form = nextProps.invoice;
            this.setState({
                invoice: form,
            })
        }
    }

    componentDidUpdate(){
	    const { invoice, isFetching, isInited} = this.state;
        if(!_.isEmpty(invoice) && isFetching && !isInited ){
	        this.setState({
                isFetching: false,
                isInited: true,
            })
        }
    }

    async onSubmit(){
	    const { invoice } = this.state;
        const errors = {
            name: !invoice.name ? this.errorMsg : '',
        };
        if(_.size(_.filter(errors, (error) => {
            return error;
        }))){
           this.setState({
               errors: errors
           })
        }else{
           this.setState({
               isFetching: true
           });
            Api.editInvoice(this.props.jwt, invoice).then((response) => {
                const result = JSON.parse(response.text);
                if(result.status){
                    if(!_.isEmpty(this.props.invoices)){
                        const invoices = this.props.invoices.map((invoice) => {
                            if(invoice.id == result.data.id){
                                return result.data
                            }else return invoice
                        });
                        this.props.dispatch(receiveNewInvoice(invoices));
                    }else{
                        this.props.dispatch(requestGetList(this.props.jwt));
                    }
                    this.props.history.push('/invoice')
                }else{
                    this.setState({
                        isFetching: false,
                        errors: result.data,
                        hair: data
                    });
                }
            }).catch((errors)=>{
                alert(errors.message)
            })


        }
    }

    onChangeValue(require, event){
	    const state = {
            invoice: Object.assign({}, this.state.invoice, {
                [event.target.name]: event.target.value
            })
        };
	    if(require){
            state.errors = Object.assign({}, this.state.errors, {
                [event.target.name]: (!event.target.value) ? this.errorMsg : ''
            })
        }
            this.setState(state);

    }

    render() {
        const { errors , invoice, isFetching } = this.state;
        if(isFetching) return <Loading/>
        return(
            <div className="">
                {isFetching ?  <Loading/> :
                    <div className="box box-primary box-edit-employee">
                        <div className="box-header text-center">
                            <h4>Edit invoice </h4>
                        </div>
                        <form>
                            <div className="box-body" >
                                <Input onChangeValue={this.onChangeValue.bind(this, true)} title={'Name *'} name={'name'}
                                       placeholder={'Enter name'} error={errors.name} type={'text'} value={invoice.name}/>
                                <div className="box-footer">
                                    <button type="button" onClick={() => this.props.history.push('/invoice')} className="btn btn-default">Back</button>
                                    <button type="button" onClick={this.onSubmit.bind(this)} className="btn btn-info pull-right">Save</button>
                                </div>
                            </div>
                        </form>
                    </div>
                }

            </div>
        )
    }
}
