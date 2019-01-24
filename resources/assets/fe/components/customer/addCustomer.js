import React, { Component } from 'react'
import Loading  from '../layout/loading'
import ClassNames from 'classnames'
import Api from '../../api'
import AddAddress from "./addAddress";
import * as _ from 'lodash'
import Input from "../partial/input";

import {receiveAddCustomer, requestGetList} from "../../actions/customer";

export default class AddCustomer extends Component{
	constructor(props) {
        super(props);
        this.state = {
            isFetching: false,
            countries: this.props.countries,
            states: this.props.states,
            types: this.props.types,
            errors: [],
            title: '',
            form: {
                id_employee: this.props.employee.id,
                address:  [],
                email: '',
                phone: '',
                full_name: '',
                type: _.first(this.props.types),
                is_special_customer: false,
                status: 'New',
                filters: this.props.filters,
                page_number: this.props.page_number
            }
        };
        this.errorMsg = 'Field is required';
    }

    async onSubmit(){
	    const { form } = this.state;
        const errors = {
            address: !form.address.address ? this.errorMsg : '',
            email: !form.email ? this.errorMsg : '',
            phone: !form.phone ? this.errorMsg : '',
            full_name: !form.full_name ? this.errorMsg : '',
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
               const fetch = await Api.addCustomer(this.props.jwt, this.state.form);
               const result = JSON.parse(fetch.text);
               if(result.status){
                   const data = {
                       data: {
                           customers: {},
                           pageLimit: 0,
                           currentPage: 0,
                           itemsPerPage:0,
                           totalItems: 0,
                           filters: {}
                       }
                   }
                   if(!_.isEmpty(this.props.customers)){
                       const customers = _.concat(this.props.customers, result.data.customer);
                       this.props.dispatch(receiveAddCustomer(customers));
                   }else{
                       this.props.dispatch(requestGetList(this.props.jwt));
                   }
                   this.props.history.push('/customer')
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
	    if(event.target.name == 'is_special_customer'){
            this.setState({
                form: Object.assign({}, this.state.form, {
                    [event.target.name]: !this.state.form[event.target.name]
                }),
            });
        }else{
            this.setState({
                form: Object.assign({}, this.state.form, {
                    [event.target.name]: event.target.value
                }),
                errors: Object.assign({}, this.state.errors, {
                    [event.target.name]: (!event.target.value) ? this.errorMsg : ''
                })
            });
        }
    }

    onChangeAddress(data){
            this.setState({
            form: Object.assign({}, this.state.form, {
                address: data
            }),
            errors: Object.assign({}, this.state.errors, {
                address: data.address ? '' : this.errorMsg
            })
        })
    }

    render(){
	    const { types, countries, states, form, isFetching } = this.state;
	    if(isFetching) return <Loading/>
        const addressTotal = _.size(form.address);

        return(
            <div className="">
                <div className="box box-primary">
                    <div className="box-header text-center">
                        <h4>Add Customer</h4>
                    </div>
                  
                    <form>
                        <div className="box-body" >
                            <Input onChangeValue={this.onChangeValue.bind(this)} title={'Email address *'} name={'email'}
                                   placeholder={'Enter email'} error={this.state.errors.email} type={'email'} value={this.state.form.email}/>
                            <Input onChangeValue={this.onChangeValue.bind(this)} title={'Phone *'} name={'phone'}
                                   placeholder={'Enter phone'} error={this.state.errors.phone} type={'text'} value={this.state.form.phone} />
                            <Input onChangeValue={this.onChangeValue.bind(this)} title={'Full name *'} name={'full_name'}
                                   placeholder={'Enter full name'} error={this.state.errors.full_name} type={'text'} value={this.state.form.full_name}
                            />

                            <div className={ClassNames({'form-group': true})}>
                                    <label>Type</label>
                                    <select name="type" id="" className={'form-control'} onChange={this.onChangeValue.bind(this)}>
                                        {types.map((type, i)=>(
                                            <option value={type} key={i}>{type}</option>
                                        ))}
                                    </select>
                            </div>
                            <div className="checkbox">
                                <label>
                                    <input type="checkbox" name={'is_special_customer'} checked={this.state.form.is_special_customer} onChange={this.onChangeValue.bind(this)} /> Special customer
                                </label>
                            </div>
                            <div className={ClassNames({'form-group': true})}>
                                    <label>Status</label>
                                    <select name="status" defaultValue={'New'} className={'form-control'} onChange={this.onChangeValue.bind(this)}>
                                            <option value={'New'}>New</option>
                                            <option value={'Supporting'}>Supporting</option>
                                            <option value={'Ordered'}>Ordered</option>
                                    </select>
                            </div>
                            <div className="">
                                <div className="address-title">
                                    <h4 className={'box-title'}>Address</h4>
                                </div>
                                <div className="">
                                    <AddAddress id={addressTotal + 1 }
                                                countries = {countries}
                                                states={states}
                                                address={this.state.form.address.address}
                                                onChangeAddress={this.onChangeAddress.bind(this)}
                                                error={this.state.errors.address}
                                                value={this.state.form.address}
                                    />
                                </div>
                            </div>

                        </div>
                         <div className="box-footer">
                            <button type="button" onClick={() => this.props.history.push('/customer')} className="btn btn-default">Back</button>
                            <button type="button" onClick={this.onSubmit.bind(this)} className="btn btn-info pull-right">Save</button>
                        </div>
                    </form>
                </div>
            </div>
        )
    }
}

