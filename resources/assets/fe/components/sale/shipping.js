import React, { Component } from 'react'
import ClassNames from "classnames";
import * as _ from "lodash";
import {updateShippingCost, updateCarrier} from "../../actions/order/cart";
import Spinner from "../layout/spinner";

export default class Shipping extends Component{
    constructor(props){
        super(props);
        this.state = {
            cart: this.props.cart,
            carriers: this.props.carriers,
            errors:{}
        };
        this.updateShippingCost = this.updateShippingCost.bind(this);
        this.updateCarrier = this.updateCarrier.bind(this);
        this.handleChangeShipping = this.handleChangeShipping.bind(this);
    }
    handleChangeShipping(event){
        let { cart } = this.state;
        let  shipping_cost = (_.isNull(event.target.value.match(/[^0-9.-]/))) ? event.target.value : cart.shipping_cost
        this.setState({
            cart: Object.assign({}, this.state.cart, {
                shipping_cost:shipping_cost,
            }),
            errors: Object.assign({}, this.state.errors, {shipping_cost: !event.target.value})
        })    
    }

    updateShippingCost(){
        if(this.state.cart.shipping_cost){
            this.props.dispatch(updateShippingCost(this.props.jwt, this.state.cart, this.props.isEditing));
        }
    }

    updateCarrier(e){
        const cart = Object.assign({}, this.state.cart, {
            id_carrier: e.target.value
        });
        if(e.target.value != 0 && cart.id_carrier != this.state.cart.id_carrier){
            this.props.dispatch(updateCarrier(this.props.jwt, cart, this.props.isEditing))
        }else{
            this.props.removeCarrier()
        }
    }

    render(){
        const {cart, carriers } = this.state;
        return(
            <div className={ClassNames({"group-input": true}, {"carrier": true} , {"form-group": true} , {'has-error': this.state.errors.shipping_cost})}>
                <span className="label-detail">Shipping</span>
                <div className="group-input-content">
                    <select defaultValue={cart.id_carrier ? parseInt(cart.id_carrier) : 0 } onChange={this.updateCarrier} className={ClassNames({'error': this.state.errors.id_carrier})}>
                        {carriers.map((carrier) => (
                            <option value={carrier.id} key={carrier.id}>{carrier.name}</option>
                        ))}
                    </select>
                    <span className="group-label-input">
                           <label>$</label>
                            <input 
                                type="text"  
                                value={cart.shipping_cost ?  cart.shipping_cost : ''} 
                                className={ClassNames({'error': this.state.errors.shipping_cost})} 
                                onChange={(event) => this.handleChangeShipping(event)} 
                                onBlur={this.updateShippingCost} 
                            />
                    </span>
                </div>
            </div>
        )
    }
}
