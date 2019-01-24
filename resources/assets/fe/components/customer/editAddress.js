import React, { Component } from 'react'
import * as _ from 'lodash'
import Input from "../partial/input";
import Loading  from '../layout/loading'
import Api from '../../api'
import {receiveList} from "../../actions/customer";

export default class EditAddress extends Component{
    constructor(props) {
        super(props);
        const states =  _.filter(this.props.states, (state) => {
            return state.id_country == this.props.address.id_country
        });
        this.errors = 'Address field is requried';
        this.state = {
            isFetching:false,
            countries: this.props.countries,
            states: states,
            address: this.props.address,
            error: this.props.error
        };
    }


    onSelectCountry(event){
        const states =  _.filter(this.props.states, (state) => {
            return state.id_country == event.target.value
        });
        this.setState({
            states: states,
            address : Object.assign(this.state.address, {
                id_country : event.target.value,
                id_state: (_.first(states)) ? _.first(states).id : null,
            })
        })
    }

    onChangeAddress(event){
        this.setState({
            address : Object.assign( this.state.address, {
                address: event.target.value,
            }),
            error: (!event.target.value) ? this.errors : ''
        })
    }

    onSelectState(event){
        this.setState({
            address : Object.assign(this.state.address, {
                id_state: event.target.value
            })
        });
    }

   async save(){
        if(!this.state.error){
            this.setState({
                 isFetching: true
            });
            try{
                const form = this.state.address;
                form.filters = this.props.filters
                const reponse = await Api.updateAddress(this.props.jwt ,form);
                const result = JSON.parse(reponse.text);

                if(result.status){
                    this.props.dispatch(receiveList(result.data.customers));
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

    render(){
        const { countries, states, address, isFetching } = this.state;
        if(isFetching) return <Loading />
        return (
            <div className="edit-address">
                <div className="col-md-6">
                    <div className="">
                        <div className="form-group">
                            <label>Country</label>
                            <select name="name" id="" className="form-control" defaultValue={address.id_country} onChange={this.onSelectCountry.bind(this)}>
                                {countries.map((country) => (
                                    <option value={country.id} key={country.id} >{country.name}</option>
                                ))}
                            </select>
                        </div>
                        <div className="form-group">
                            <label>State</label>
                            <select name="name" id="" className="form-control" defaultValue={address.id_state} onChange={this.onSelectState.bind(this)}>
                                {states.map((state) => (
                                    <option value={state.id} key={state.id} >{state.name}</option>
                                ))}
                            </select>
                        </div>
                        <Input
                            onChangeValue={this.onChangeAddress.bind(this)} title={'Address *'} name={'address'}
                            placeholder={'Enter address'} error={this.state.error} type={'text'} value={address.address}/>
                    </div>
                    <button className={'btn btn-info pull-right'} onClick={this.save.bind(this)}>Save</button>
                </div>
            </div>
        )
    }
}
