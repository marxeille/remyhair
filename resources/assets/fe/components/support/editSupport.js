import React, { Component } from 'react'
import Loading  from '../layout/loading'
import ClassNames from 'classnames'
import Api from '../../api'
import * as _ from 'lodash'
import {receiveAddSupport, requestGetList} from "../../actions/support";

export default class EditSupport extends Component{
    
    constructor(props) {
        super(props);
        this.state = {
            invoices_status: this.props.invoices_status,
            statuss: this.props.status,
            sources: this.props.source,
            isFetching: false,
            errors: [],
            form: {
                id: this.props.match.params.id,
                invoice_status: '',
                id_employee: 0,
                id_customer: 0,
                invoices_number: '',
                source: '',
                status: '',
                notes: [],
                customer: '',
                complains: [],
            },
        }
        this.errorMsg = 'Field is required';
    }

    async onSubmit(){
        const { form } = this.state;
        const errors = {
            employee: !form.id_employee ? this.errorMsg : '',
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
               const fetch = await Api.editSupport(this.props.jwt, this.state.form);
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
        });
    }

    async componentWillMount(){
	    const response = await Api.getSupport(this.props.jwt, this.props.match.params.id);
        const result = JSON.parse(response.text);
        result.data.filters = this.props.filters;
	    if(result.status){
            this.setState({
                isFetching: false,
                form: Object.assign(
                    {}, 
                    this.state.form, 
                    {
                        invoice_status: result.data.support.id_invoice_status,
                        id_employee: result.data.support.id_employee,
                        id_customer: result.data.support.id_customer,
                        invoices_number: result.data.support.id_invoice_status,
                        source: result.data.support.source,
                        status: result.data.support.status,
                        notes: result.data.support.notes,
                        customer: result.data.support.customer,
                        complains: result.data.support.complains,
                    }
                ),
            })
        }else{
	        alert(response.msg)
        }
    }

    handleAddMore(name) {
        this.setState({
            form: Object.assign({}, this.state.form, {
                [name]: [...this.state.form[name], {id: 0, content: '',}]
            }),
        })
    }

    onChangeNote(index, event){
        let notes = _.clone(this.state.form.notes);
        notes[index].content = event.target.value;
        this.setState({
            form: Object.assign({}, this.state.form, {
                notes: notes
            }),
        })

    }

    onChangeComplain(index, event){
        let complains = _.clone(this.state.form.complains);
        complains[index].content = event.target.value;
        this.setState({
            form: Object.assign({}, this.state.form, {
                complains: complains
            }),
        })
    }

    render(){
        const { invoices_status, statuss, sources, form, isFetching } = this.state;
        if(isFetching) return (<Loading />)
        return(
            <div className="box box-primary">
                <div className="box-header with-border text-center">
                    <h1 className="box-title">Support</h1>
                </div>
                <form className="form-horizontal">
                    {
                        form.customer ?
                            <div className="row">
                                <span className="full-name">Customer: {form.customer.full_name}</span>
                            </div>
                        :
                            null
                    }
                    <div className="box-body">
                        <div className="row">
                            <div className="col-xs-6">
                                <label>Invoice status</label>
                                <select name="id_invoice_status" value={form.id_invoice_status} id="" className={'form-control'} onChange={this.onChangeValue.bind(this)}>
                                    {invoices_status.map((type, i)=>(
                                        <option value={type['id']} key={i} >{type['name']}</option>
                                    ))}
                                </select>
                            </div>
                            <div className="col-xs-6">
                                <label>Invoice Number</label>
                                <input name="invoices_number"  onChange={this.onChangeValue.bind(this)} className="form-control" type="text" placeholder="Default input" value={form.invoices_number}/>
                            </div>
                        </div>
                    </div>
                    <div className="box-body row">
                        <div className="col-xs-6">
                            <label>Status</label>
                            <select name="status" value={form.status} id="" className={'form-control'} onChange={this.onChangeValue.bind(this)}>
                                {statuss.map((status, i)=>(
                                    <option value={status} key={status} >{status}</option>
                                ))}
                            </select>
                        </div>
                        <div className=" col-xs-6">
                            <label>Source</label>
                            <select name="source" value={form.source} id="" className={'form-control'} onChange={this.onChangeValue.bind(this)}>
                                {sources.map((source, i)=>(
                                    <option value={source} key={source} >{source}</option>
                                ))}
                            </select>
                        </div>
                    </div>
                    <div className="box-body">
                        <label>Note</label>
                        {
                            form.notes.length ?

                                form.notes.map( (note, index) => (
                                    <textarea key = {index} name="note" onBlur={ (event) => this.onChangeNote(index, event)} className="support-note form-control" rows="3" placeholder="note" defaultValue={note.content}></textarea>
                                ))
                            :
                            <textarea name="note" onBlur={ (event) => this.onChangeNote(0, event)} className="support-note form-control" rows="3" placeholder="note"></textarea>   
                        }
                        <button type="button" onClick={() => this.handleAddMore('notes')} className="btn btn-default">+ Note</button>
                    </div>
                    <div className="box-body">
                    <label>Complain</label>
                    {
                        form.complains.length ?

                            form.complains.map( (complain, index) => (
                                <textarea key={index} name="complain" onBlur={ (event) => this.onChangeComplain(index, event)} className="support-complain form-control" rows="3" placeholder="complain" defaultValue={complain.content}></textarea>
                            ))
                        :
                            <textarea name="complain" onBlur={ (event) => this.onChangeComplain(0, event)} className="support-complain form-control" rows="3" placeholder="complain"></textarea>
                    }
                    <button type="button" onClick={() => this.handleAddMore('complains')} className="btn btn-default">+ Complain</button>
                </div>
                    <div className="box-footer">
                        <button type="button" onClick={() => this.props.history.push('/support')} className="btn btn-default">Back</button>
                        <button type="button" onClick={this.onSubmit.bind(this)} className="btn btn-info pull-right">Save</button>
                    </div>
                </form>
            </div>
        )
    }
}
