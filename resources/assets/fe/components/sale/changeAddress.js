import React, { Component } from 'react'
import * as _ from "lodash";
import {renderAddress} from "../../utility";
import Loading from "../layout/loading";
import {addAddress, requestUpdateAddress} from "../../actions/order/cart";
import ClassNames from "classnames";

export default class ChangeAddress extends Component{
    constructor(props){
        super(props);
        const states = _.filter(this.props.states, (state) => {
            return state.id_country ==  _.first(this.props.countries).id
        });
        const selected = _.size(this.props.value) ? this.props.value : {
            id_country: _.first(this.props.countries).id,
            id_state: (_.first(states)) ? _.first(states).id : null,
            address: ''
        };

        this.state = {
            countries: this.props.countries,
            states: states,
            selected: selected,
            loading: false
        };
        this.changeAddress = this.changeAddress.bind(this);
        this.addAddress = this.addAddress.bind(this);
    }
    onSelectCountry(event){
        const states =  _.filter(this.props.states, (state) => {
            return state.id_country == event.target.value
        });

        this.setState({
            states: states,
            selected : Object.assign(this.state.selected, {
                id_country : event.target.value,
                id_state: (_.first(states)) ? _.first(states).id : null,
            })
        })
    }

    onChangeAddress(event){
        this.setState({
            selected : Object.assign( this.state.selected, {
                address: event.target.value,
            }),
            error: (!event.target.value) ? true : ''
        })
    }

    addAddress(){
        if(!this.state.error && this.state.selected.address){
            this.setState({
                loading: true
            });
            this.props.dispatch(addAddress(this.props.jwt, this.state.selected, this.props.cart.id));
        }
    }

    onSelectState(event){
        this.setState({
            selected : Object.assign(this.state.selected, {
                id_state: event.target.value
            })
        });
    }

    componentWillReceiveProps(nextProps){
        this.setState({
            loading: false
        });
    }

    changeAddress(e){
        const { customer } = this.props.cart;
        this.setState({
            loading: true
        });
        this.props.dispatch(requestUpdateAddress(this.props.jwt, _.first(_.filter(customer.address, (add) => add.id == e.target.value)), this.props.cart.id));
    }

    render(){
        const { countries, states, cart } = this.props;
        const { loading } = this.state;
        const address = _.find(cart.customer.address, (add) => { return cart.id_address == add.id; });
        const customer = cart.customer;
        return(
            <div className="form-add-address">
                {
                    loading ?                    
                        <Loading/>
                    :
                    <div className="change-address">   
                        <div className="view-title"><h4 className="title-form">Add Address</h4></div>
                        <button className="btn-close-popup" onClick={this.props.onClose}></button>
                        <div className="change-address-form">
                            <div className="left-content">
                                <div className="input-group">
                                    <label>Country</label>
                                    <select name="name" id="" className="form-control" defaultValue={this.state.selected.id_country} onChange={this.onSelectCountry.bind(this)}>
                                        {countries.map((country, key) => (
                                            <option key={key} value={country.id} >{country.name}</option>
                                        ))}
                                    </select>
                                </div>
                                <div className="input-group">
                                    <label>State</label>
                                    <select name="name" className="form-control" defaultValue={this.state.selected.id_state} onChange={this.onSelectState.bind(this)}>
                                        {states.map((state, key) => (
                                            <option key={key} value={state.id} >{state.name}</option>
                                        ))}
                                    </select>
                                </div>
                                <div className={ClassNames({'input-group': true},{'label-empty': true}, {'has-error': this.state.error})}>
                                    <label>Address</label>
                                    <input type='text' onChange={this.onChangeAddress.bind(this)}  value={this.state.selected.address} />
                                </div>
                            </div>
                            <div className="right-content">
                                <div className="list-address-current">
                                    {customer.address.map((add, index) => (
                                        <div className="item-address" key={add.id}>
                                            <input key={index} type="radio" name={'checked-address'} value={add.id} defaultChecked={add.id == address.id} onClick={this.changeAddress}/>
                                            <span>{renderAddress(add, this.props.countries, this.props.states)}</span>
                                        </div>
                                    ))}
                                </div> 
                            </div>
                        </div>
                        <button className="btn-save-address" disabled={this.state.error || !this.state.selected.address} onClick={this.addAddress}>Save</button>
                    </div>
                }
            </div>

        )
    }
}
