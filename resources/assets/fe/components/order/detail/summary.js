import React, {PureComponent} from 'react';
import {showPrice} from "../../../utility";
import * as _ from "lodash";

export default class Summary extends PureComponent{
    render(){
        const { carriers } = this.props.env;
        const { order} = this.props;
        const {total_shipping, total_discount, paid_order, total_payment_fee } = order;
        return(
            <div style={this.props.style}>
                <div className="input-group">
                    <label>Subtotal:</label>
                    <p>{showPrice(order.sub_total)}</p>
                </div>
                <div className="input-group">
                    <label>Carrier:</label>
                    <p>{_.first(_.filter(carriers, (c) => c.id == parseInt(order.id_carrier))).name}</p>
                </div>
                <div className="input-group">
                    <label>Shipping:</label>
                    <p>{showPrice(total_shipping)}</p>
                </div>
                <div className="input-group">
                    <label>Discount:</label>
                    <p>{showPrice(total_discount)}</p>
                </div>
                <div className="input-group">
                    <label>Payment fee:</label>
                    <p>{showPrice(total_payment_fee)}</p>
                </div>
                <div className="input-group">
                    <label>Total:</label>
                    <p>{showPrice(order.total_paid)}</p>
                </div>
            </div>
        )
    }
}
