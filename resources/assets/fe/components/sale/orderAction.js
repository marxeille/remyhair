import React, { Component } from 'react'
import * as _ from 'lodash'
import {cancelOrder, completeOrder} from "../../actions/order/cart";
import ClassNames from "classnames";
import moment from "frozen-moment";

export default class OrderAction extends Component{
    
    completePayment() {
        this.props.changeModal('addPayment')
    }

    updateOrder(){
        const order = this.props.cart;
        order.note = localStorage.getItem('note', '');
        order.img = localStorage.getItem('image', '');
        order.reason = localStorage.getItem('reason', '');
        order.date_ship =  moment();
        const {total} = order.summary;
        const customerBalance = this.props.isEditing ? parseFloat(order.summary.customer_balance) + (parseFloat(_.last(this.props.order.paid_order).paid) - parseFloat(total.sale)) : 0;
        order.paid = this.props.isEditing ? (customerBalance < 0 ) ? _.round(-(customerBalance), 2) : 0 :  total.sale > order.summary.customer_balance ? _.round(total.sale - order.summary.customer_balance, 2) : 0;
        order.id_state = _.first(this.props.initData.order_states).id;
        order.id_payment = _.first(this.props.initData.payments).id;
        this.props.dispatch(completeOrder(this.props.jwt, order, this.props.order, this.onUpdateOrderSuccess.bind(this)));
    }

    onUpdateOrderSuccess(){
            alert('Update order successfully');
        this.props.onCancelOrder();
        this.props.dispatch(cancelOrder(this.props.jwt));
    }

    render(){
        const { cart, isEditing, order } = this.props;
        const  error = !cart || !cart.id || !cart.id_address || !cart.id_carrier || !cart.id_customer|| !cart.id_employee || _.isEmpty(cart.products);
        return (
            <div className="orderControlButton">
                <button className="btn-cancel" onClick={() => {
                    if(confirm('Are you sure?')){
                        this.props.onCancelOrder();
                        this.props.dispatch(cancelOrder(this.props.jwt));
                    }
                }}>Cancel</button>
                {isEditing ?
                     cart.summary.total.sale >  _.last(order.paid_order).paid ?
                         <button className={ClassNames({'btn-pay-complete': true, 'btn-pay-success': !error})} disabled={error} onClick={() => this.completePayment()}>Pay Complete</button>
                         :
                         <button className={ClassNames({'btn-pay-complete': true, 'btn-pay-success': !error})} disabled={error} onClick={() => this.updateOrder()}>Update order</button>
                    :
                    <button className={ClassNames({'btn-pay-complete': true, 'btn-pay-success': !error})} disabled={error} onClick={() => this.completePayment()}>Pay Complete</button>
                }
            </div>
        )
    }
}
