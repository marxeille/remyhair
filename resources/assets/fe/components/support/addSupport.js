import React, { Component } from 'react'
import Loading  from '../layout/loading'
import ClassNames from 'classnames'
import Api from '../../api'
import * as _ from 'lodash'
import {receiveAddSupport, requestGetList} from "../../actions/support";
import Input from "../partial/input";
import { Link } from 'react-router-dom'
export default class AddSupport extends Component{
    constructor(props) {
        super(props);
        this.state = {
            invoices_status: this.props.invoices_status,
            supportSource: this.props.source,
            supportStatus: this.props.supportStatus,
            customerList: [],
            customer: null,
            moreNote: false,
            moreComplain: false,
            isFetching: false,
            errors: [],
            form: {
                id_employee: this.props.employee.id,
                id_customer: '',
                invoices_number: '',
                source: _.first(this.props.source),
                status: _.first(this.props.supportStatus),
                id_invoice_status: _.first(this.props.invoices_status).id,
                notes: [''],
                complains: [''],
            },
            keyword: '',
        }
        this.errorMsg = 'Customer is required';
    }

    async onSubmit(){
        const { form } = this.state;
        const errors = {
            customer: !form.id_customer ? this.errorMsg : '',
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
           try{
               const fetch = await Api.addSupport(this.props.jwt, this.state.form);
               const result = JSON.parse(fetch.text);
               if(result.status){
                   const data = {
                       data: {
                           supports: {},
                           pageLimit: 0,
                           currentPage: 0,
                           itemsPerPage:0,
                           totalItems: 0,
                           filters: {}
                       }
                   }
                   if(!_.isEmpty(this.props.supports)){
                       const supports = _.concat(this.props.supports, result.data.support);
                       this.props.dispatch(receiveAddSupport(supports));
                   }else{
                       this.props.dispatch(requestGetList(this.props.jwt));
                   }
                   this.props.history.push('/support')
               }else{
                   this.setState({
                       isFetching: false,
                       errors: Object.assign({}, this.state.errors, result.data)
                   })
               }
           }catch(errors){
               alert(errors.message)
           }
        }
    }
    onChangeValue(event){
        this.setState({
            form: Object.assign({}, this.state.form, {
                [event.target.name]: event.target.value
            }),
            errors: Object.assign({}, this.state.errors, {
                [event.target.name]: ''
            })
        });
    }
    handleAddMore(name) {
        this.setState({
            form: Object.assign({}, this.state.form, {
                [name]: [...this.state.form[name], ['']]
            }),
        })
    }
    onChangeKeyWord(event){
        this.setState({
            keyword:event.target.value
        });
       this.onSearchCustomer();
    }
    async onSearchCustomer(){
        const { keyword } = this.state;
        const fetch = await Api.searchCustomer(this.props.jwt, keyword);
        const result = JSON.parse(fetch.text);
        this.setState({
            customerList: result.status == true ? result.data.customer : [],
        });
        
    }
    selectedCustomer(event){
        this.setState({
            form: Object.assign({}, this.state.form, {
                id_customer: event.target.value
            }),
            customerList: [],
            keyword: '',
            customer: event.target.dataset.index,
        });
    }  
    onAdd(data, index){
        let notes = _.clone(this.state.form.notes);
        notes[index] = data;
        this.setState({
            form: Object.assign({}, this.state.form, {
                notes: notes
            }),
        })
        
    }
    onAddComplain(data, index){

        let complains = _.clone(this.state.form.complains);
        complains[index] = data;
        this.setState({
            form: Object.assign({}, this.state.form, {
                complains: complains
            }),
        })
    }
    componentDidMount() {
        this.onSearchCustomer =  _.debounce(this.onSearchCustomer, 500);      
    }
    async componentWillMount(){
        if(this.props.match.params.id){
            const fetch = await Api.getCustomer(this.props.jwt, this.props.match.params.id);
            const result = JSON.parse(fetch.text);
            this.setState({
                form: Object.assign({}, this.state.form, {
                    id_customer: this.props.match.params.id
                }),
                customerList: [],
                customer: result.data.full_name,
            });
        }
    }

    goBack(){
        window.history.back();
    }
    
    clearCustomer(){
        this.setState({
            customer: null,
            form: Object.assign({}, this.state.form, {
                id_customer: 0
            }),
        });
    }

    onChangeNote(index, event){
        let notes = _.clone(this.state.form.notes);
        notes[index] = event.target.value;
        this.setState({
            form: Object.assign({}, this.state.form, {
                notes: notes
            }),
        })

    }

    onChangeComplain(index, event){
        let complains = _.clone(this.state.form.complains);
        complains[index] = event.target.value;
        this.setState({
            form: Object.assign({}, this.state.form, {
                complains: complains
            }),
        })
    }

    render(){
        const { invoices_status, customerList, form, customer, errors, supportStatus, supportSource, isFetching} = this.state;
        if(isFetching) return (<Loading />)
        return(
            <div className="box box-primary">
                <div className="box-header with-border text-center">
                    <h1 className="box-title">Support</h1>
                </div>
                <form className="form-horizontal">
                    <div className="box-body">
                        <div className="row">
                            <div className="col-xs-7 col-md-10">
                                <div id="custom-search-input">
                                    <div className="input-group col-md-12">
                                        <Input
                                            onChangeValue={this.onChangeKeyWord.bind(this)} name={'keyWord'}
                                            placeholder={'search customer here...'}
                                            error={this.state.error} type={'text'}  
                                            value={this.state.keyword}
                                        />
                                        <span className="input-group-btn">
                                            <button className="btn btn-info" type="button" onClick={this.onSearchCustomer.bind(this)}>
                                                <i className="glyphicon glyphicon-search"></i>
                                            </button>
                                        </span>
                                    </div>
                                    {
                                        customerList.length ?
                                            <div className="search-result">
                                                <ul>
                                                    {
                                                        customerList.map((customer, i)=>(
                                                            <li key ={i} onClick={evt => this.selectedCustomer(evt)} data-index={customer.full_name} value={customer.id}>{customer.full_name} ({customer.email})</li>
                                                        ))
                                                    }
                                                </ul>
                                            </div>   

                                        :
                                            null
                                    }
                                     
                                    {
                                        customer ?
                                        <div className="selected-search">
                                            <span>{customer}</span>
                                            <button className={'btn btn-flat'} onClick={(e) => this.clearCustomer()}>x</button>
                                        </div>
                                        : null
                                    }
                                </div>
                            </div>
                            <div className="col-xs-5 col-md-2">
                                <Link to={'customer/add'} className='btn btn-fat'>
                                    <i className='fa fa-plus'></i> Create Customer
                                </Link>
                            </div>
                        </div>
                    </div>
                    <div className={ClassNames({'required-txt': true}, {'has-error': errors.customer})}>
                        <span className={ClassNames({'help-block': true},{'hidden': !errors})}>{errors.customer}</span>
                    </div>
                    <div className="box-body">
                        <div className="row">
                            <div className="col-xs-6">
                                <label>Invoice status</label>
                                <select name="id_invoice_status" id="" className={'form-control'} onChange={this.onChangeValue.bind(this)}>
                                    {invoices_status.map((type, i)=>(
                                        <option key={i} value={type['id']} >{type['name']}</option>
                                    ))}
                                </select>
                            </div>
                            <div className={ClassNames({'col-xs-6': true}, {'has-error': errors.invoice_number})}>
                                <label>Invoice Number</label>
                                <input name="invoice_number"  onChange={this.onChangeValue.bind(this)} className="form-control" type="text" placeholder="Default input" />
                                <span className={ClassNames({'help-block': true},{'hidden': !errors})}>{errors.invoice_number}</span>
                            </div>
                        </div>
                    </div>
                  
                    <div className="box-body row">
                        <div className={ClassNames({'col-xs-6': true}, {'has-error': errors.status})}>
                            <label>status</label>
                            <select name="status" id="" className={'form-control'} onChange={this.onChangeValue.bind(this)}>
                                {supportStatus.map((status, i)=>(
                                    <option key={i} value={status} >{status}</option>
                                ))}
                            </select>
                        </div>
                        <div className=" col-xs-6">
                            <label>Source</label>
                            <select name="source" id="" className={'form-control'} onChange={this.onChangeValue.bind(this)}>
                                {supportSource.map((source, i)=>(
                                    <option key={i} value={source} >{source}</option>
                                ))}
                            </select>
                        </div>
                    </div>
                    
                    <div className="box-body">
                        <label>Note</label>
                        {
                            form.notes.map( (note, index) => (
                                <textarea key = {index} name="note" onBlur={ (event) => this.onChangeNote(index, event)} className="support-note form-control" rows="3" placeholder="note" defaultValue={note}></textarea>
                            ))
                        }
                        <button type="button" onClick={() => this.handleAddMore('notes')} className="btn btn-default">+ Note</button>
                    </div>
                    <div className="box-body">
                        <label>Complain</label>
                        {
                            form.complains.map( (complain, index) => (
                                <textarea key={index} name="complain" onBlur={ (event) => this.onChangeComplain(index, event)} className="support-complain form-control" rows="3" placeholder="complain" defaultValue={complain}></textarea>
                            ))
                        }
                        <button type="button" onClick={() => this.handleAddMore('complains')} className="btn btn-default">+ Complain</button>
                    </div>
                    <div className="box-footer">
                        <button type="button" onClick={this.goBack.bind(this)} className="btn btn-default">Back</button>
                        <button type="button" onClick={this.onSubmit.bind(this)} className="btn btn-info pull-right">Save</button>
                    </div>
                </form>
            </div>
        )
    }
}
