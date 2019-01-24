import React, { Component } from 'react'
import Loading  from '../layout/loading'
import ClassNames from 'classnames'
import Api from '../../api'
import EditAddress from "./editAddress";
import * as _ from 'lodash'
import Input from "../partial/input";
import {receiveAddCustomer, receiveList, requestGetList} from "../../actions/customer";

export default class EditCustomer extends Component{
	constructor(props) {
        super(props);
        this.state = {
            isFetching: true,
            countries: this.props.countries,
            states: this.props.states,
            types: this.props.types,
            errors: [],
            title: '',
            form: {
                id_employee: this.props.employee.id,
                address: [],
                email: null,
                phone: null,
                full_name: null,
                type: _.first(this.props.types),
                is_special_customer: false,
                status: 'New',
                filters: this.props.filters,
                page_number: this.props.page_number
            }
        };
        this.errorMsg = 'Field is required';
    }

    async onSubmitInfomation(){
	    const { form } = this.state;
        const errors = {
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
               const fetch = await Api.editCustomer(this.props.jwt, form);
               const result = JSON.parse(fetch.text);
               if(result.status){
                   if(!_.isEmpty(this.props.customers)){
                        const customers = this.props.customers.map((customer) => {
                            if(customer.id == result.data.customer.id){
                                    return result.data.customer
                            }else return customer
                        })
                       this.props.dispatch(receiveAddCustomer(customers));
                   }else{
                       this.props.dispatch(requestGetList(this.props.jwt));
                   }
                   this.props.history.push('/customer');

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

    async componentWillMount(){
	    const response = await Api.getCustomer(this.props.jwt, this.props.match.params.id);
	    const result = JSON.parse(response.text);
	    result.data.filters = this.props.filters;
	    if(result.status){
           this.setState({
               isFetching: false,
               form: result.data
           })
        }else{
	        alert(response.msg)
        }
    }

    renderAddress(){
	    const addresses = this.state.form.address;
        const { countries, states, form } = this.state;
        if(_.size(addresses)){
	        return (
	            <div className="addresses-box">
                    <div className="box-header">
                        <h2 className={'box-title'}>Address</h2>
                    </div>
                    <div className="box-body">
                        {addresses.map((address) => (
                            <div key={address.id}>
                                <EditAddress
                                    id={address.id}
                                    countries = {countries}
                                    states={states}
                                    address={address}
                                     jwt={this.props.jwt}
                                    history={this.props.history}
                                    dispatch={this.props.dispatch}
                                    filters={form.filters}
                                />
                            </div>
                        ))}
                    </div>
                </div>
            )
        }
    }

    render(){
        const { types, form, isFetching } = this.state;
	    if(isFetching) return <Loading/>
        return(
            <div className="">
                <div className="box box-primary">
                    <div className="box-header text-center">
                        <h4>Edit Customer</h4>
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
                                    <label >Type</label>
                                    <select name="type" defaultValue={form.type} className={'form-control'} onChange={this.onChangeValue.bind(this)}>
                                        {types.map((type, i)=>(
                                            <option value={type} key={i} >{type}</option>
                                        ))}
                                        </select>
                            </div>
                            <div className="checkbox">
                                <label>
                                    <input type="checkbox" name={'is_special_customer'} checked={this.state.form.is_special_customer} onChange={this.onChangeValue.bind(this)} /> Special customer
                                </label>
                            </div>

                            <div className={ClassNames({'form-group': true})}>
                                    <label >Status</label>
                                    <select name="status" defaultValue={form.status} className={'form-control'} onChange={this.onChangeValue.bind(this)}>
                                        <option value={'New'}>New</option>
                                        <option value={'Supporting'}>Supporting</option>
                                        <option value={'Ordered'}>Ordered</option>
                                    </select>
                            </div>

                        </div>
                         <div className="box-footer">
                            <button type="button" onClick={() => this.props.history.push('/customer')} className="btn btn-default">Back</button>
                            <button type="button" onClick={this.onSubmitInfomation.bind(this)} className="btn btn-info pull-right">Save</button>
                        </div>
                    </form>
                </div>
                {this.renderAddress()}
            </div>
        )
    }
}

