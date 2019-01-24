import React, { Component } from 'react'
import * as _ from 'lodash'
import {showPrice} from "../../utility";

export default class Summary extends Component{
    constructor(props){
        super(props);
        this.state = {
            cart: this.props.cart
        }
    }

    componentWillReceiveProps(props){
        if(!_.isEqual(props.cart.summary, this.state.cart.summary) || !_.isEqual(props.cart.balance, this.state.cart.balance)) {
            props.cart.balance =  localStorage.getItem('cartCustomerBalance') ;
            this.setState({cart: props.cart})
        }
    }

    render(){
        const {cart} = this.state;
        const {total} = cart.summary;
        const { isEditing, order } = this.props;
        let paid = 0;
        if(isEditing){
            for(let i = 0; i < order.paid_order.length; i++){
                paid += parseFloat(order.paid_order[i].paid);
            }
        }
        const customerBalance = isEditing ? parseFloat(cart.balance) + (parseFloat(paid) - parseFloat(total.sale)) : parseFloat(cart.balance) - parseFloat(total.sale) ;
        const amountDue = isEditing ? (customerBalance < 0 ) ? showPrice(_.round(-(customerBalance), 2)) : showPrice(0) : parseFloat(total.sale) > parseFloat(cart.balance) ? showPrice(_.round(parseFloat(total.sale) - parseFloat(cart.balance), 2)) : showPrice(0);
        return(
                <div className="orderTotal">
                    <div className="box-order-total">
                        <div className="orderTotal-item">
                            <p className="orderTotal-label">Total Product: </p>
                            <p className="orderTotal-money">{showPrice(total.products)}</p>
                        </div>
                        <div className="orderTotal-item">
                            <p className="orderTotal-label">Total Shipping: </p>
                            <p className="orderTotal-money">{showPrice(total.shipping_cost)}</p>
                        </div>
                        <div className="orderTotal-item">
                            <p className="orderTotal-label">Total Discount:</p>
                            <p className="orderTotal-money">{showPrice(total.discount)}</p>
                        </div>
                        <div className="orderTotal-item">
                            <p className="orderTotal-label">Total payment fee:</p>
                            <p className="orderTotal-money">{showPrice(_.round(cart.summary.total.total_payment_fee, 2))}</p>
                        </div>
                        <div className="orderTotal-item">
                            <p className="orderTotal-label">Total Cart:</p>
                            <p className="orderTotal-money">{showPrice(total.sale)}</p>
                        </div>
                        <div className="orderTotal-item">
                            <p className="orderTotal-label">Customer Balance:</p>
                            <p className="orderTotal-money">{showPrice(_.round(cart.balance, 2))}</p>
                        </div>
                        <div className="orderTotal-item">
                            <p className="orderTotal-label">Amount Due:</p>
                            <p className="orderTotal-money">{amountDue}</p>
                        </div>
                    </div>
                </div>

        )
    }
}
