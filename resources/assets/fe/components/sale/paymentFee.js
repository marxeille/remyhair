import React, { Component } from 'react'
import { updatePaymentFee } from "../../actions/order/cart";
import * as _ from "lodash";
import ClassNames from "classnames";
import Spinner from "../layout/spinner";

export default class PaymentFee extends Component{
    constructor(props) {
        super(props);
        this.state = {
            errors:{},
            cart: this.props.cart,
        };
        this.updatePaymentFee = this.updatePaymentFee.bind(this)
        this.handleChangePaymentFee = this.handleChangePaymentFee.bind(this)
    }
    handleChangePaymentFee(event){
        let { cart } = this.state;
        this.setState({
            cart: Object.assign({}, this.state.cart, {
                payment_fee:(_.isNull(event.target.value.match(/[^0-9.-]/))) ? event.target.value : cart.payment_fee,
            }),
            errors: Object.assign({}, this.state.errors, {payment_fee: !event.target.value})
        })
    }
    updatePaymentFee(){
        if(this.state.cart.payment_fee){
            this.props.dispatch(updatePaymentFee(this.props.jwt, this.state.cart, this.props.isEditing));
        }
    }

    render(){
        const { cart} = this.state;
        return(
            <div className="group-input">
                <span className="label-detail">Fee</span>
                <div className="group-input-content">
                    <span className="group-label-input">
                        <label>%</label>
                        <input 
                            type="text"  
                            value={cart.payment_fee ? cart.payment_fee : ''} 
                            className={ClassNames({'error': this.state.errors.payment_fee})} 
                            onChange={(event) => this.handleChangePaymentFee(event)} 
                            onBlur={this.updatePaymentFee} 
                        />
                    </span>
                </div>
            </div>
        )
    }
}
