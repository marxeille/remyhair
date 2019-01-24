import React, { Component } from 'react'
import Loading  from '../layout/loading'
import Api from '../../api'
import * as _ from 'lodash'
import Input from "../partial/input";
import {receiveNewHair, requestPayment, requestGetList, receiveNewPayment} from "../../actions/payment";
import ClassNames from "classnames";


export default class EditPayment extends Component{
    constructor(props) {
        super(props);
        this.state = {
            isFetching: true,
            errors: [],
            title: '',
            isInited: false,
            payment: this.props.payment,
        };
        this.errorMsg = 'Field is required';
        this.onSubmit = this.onSubmit.bind(this);
        this.onChangeValue = this.onChangeValue.bind(this);
    }

    componentWillMount(){
        this.props.dispatch(
            requestPayment(this.props.jwt, this.props.match.params.id)
        );
    }

    componentWillReceiveProps(nextProps){
        if(!_.isEmpty(nextProps.payment)){
            const form = nextProps.payment
            this.setState({
                payment: form,
            })
        }
    }

    componentDidUpdate(){
	    const { payment, isFetching, isInited} = this.state
        if(!_.isEmpty(payment) && isFetching && !isInited ){
	        this.setState({
                isFetching: false,
                isInited: true,
            })
        }
    }

    async onSubmit(){
	    const { payment } = this.state;
        const errors = {
            name: !payment.name ? this.errorMsg : '',
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
            Api.editPayment(this.props.jwt, payment).then((response) => {
                const result = JSON.parse(response.text);
                if(result.status){
                    if(!_.isEmpty(this.props.payments)){
                        const payments = this.props.payments.map((payment) => {
                            if(payment.id == result.data.id){
                                return result.data
                            }else return payment
                        });
                        this.props.dispatch(receiveNewPayment(payments));
                    }else{
                        this.props.dispatch(requestGetList(this.props.jwt));
                    }
                    this.props.history.push('/payment')
                }else{
                    this.setState({
                        isFetching: false,
                        errors: result.data,
                    });
                }
            }).catch((errors)=>{
                alert(errors.message)
            })


        }
    }

    onChangeValue(require, event){
	    const state = {
            payment: Object.assign({}, this.state.payment, {
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
        const { errors , payment, isFetching } = this.state;
        if(isFetching) return <Loading/>
        return(
            <div className="">
                {isFetching ?  <Loading/> :
                    <div className="box box-primary box-edit-employee">
                        <div className="box-header text-center">
                            <h4>Edit Payment</h4>
                        </div>
                        <form>
                            <div className="box-body" >
                                <Input onChangeValue={this.onChangeValue.bind(this, true)} title={'Name *'} name={'name'}
                                       placeholder={'Enter name'} error={errors.name} type={'text'} value={payment.name}/>

                                <div className="box-footer">
                                    <button type="button" onClick={() => this.props.history.push('/payment')} className="btn btn-default">Back</button>
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
