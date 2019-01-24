import React, {Component} from 'react'
import {cancelOrder, completeOrder} from "../../actions/order/cart";
import {showPrice} from "../../utility";
import DatePicker from "react-datepicker";
import moment from "frozen-moment";
import "react-datepicker/dist/react-datepicker.css";
import ClassNames from "classnames";
import * as _ from "lodash";
import Loading from "../layout/loading";

export default class AddPayment extends Component{
    constructor(props){
        super(props);
        const order = props.cart;
        order.note = localStorage.getItem('note', '');
        order.img = localStorage.getItem('image', '');
        order.reason = localStorage.getItem('reason', '');
        order.date_ship =  moment();
        const {total} = order.summary;
        let paid = 0;
        if(this.props.isEditing){
            for(let i = 0; i < this.props.order.paid_order.length; i++){
                paid += parseFloat(this.props.order.paid_order[i].paid);
            }
        }
        const customerBalance = this.props.isEditing ? parseFloat(order.balance) + (parseFloat(paid) - parseFloat(total.sale)) : 0;
        order.paid = this.props.isEditing ? (customerBalance < 0 ) ? _.round(-(customerBalance), 2) : 0 :  total.sale > order.balance ? _.round(total.sale - order.balance, 2) : 0;
        order.id_state = _.first(this.props.initData.order_states).id;
        order.id_payment = _.first(this.props.initData.payments).id;
        this.totalCart = this.props.isEditing ? order.paid :  total.sale > order.balance ? showPrice(_.round(total.sale - order.balance, 2)) : 0;
        this.state = {
            order: order,
            errors: {},
            completeOrder: false
        };
        this.onChangePaid = this.onChangePaid.bind(this);
        this.completeOrder = this.completeOrder.bind(this);
        this.onSuccess = this.onSuccess.bind(this);
    }

    completeOrder(){
        const { order, errors } = this.state;
        if(!errors.paid && order.id_payment && parseFloat(order.paid) >= 0) {
            this.setState({
                loading: true
            });
            const data = _.clone(order);
            const dataToFetch = _.clone(order);
            order.date_ship = dataToFetch.date_ship.format(
                "YYYY-MM-DD"
            );
            this.props.dispatch(completeOrder(this.props.jwt, order, this.props.order, this.onSuccess));
            this.setState({
               order:  data
            });
        }else{
            if(!order.paid) alert('Paid invalid');
        }
    }

    componentWillUnmount(){
        if(this.state.completeOrder) {
            this.props.onCancelOrder();
            this.props.dispatch(cancelOrder(this.props.jwt));
        }
    }

    onChangeDate(field, date) {
        this.setState({
            order: Object.assign({}, this.state.order, {
                [field]: date.format('YYYY-MM-DD 23:59:59')
            })
        });
    }

    onChangePaid(event){
        this.setState({
            order: Object.assign({}, this.state.order, {
                paid:  (_.isNull( event.target.value.match(/[^0-9.-]/)))
                    ? event.target.value : this.state.order.paid
            }),
            errors: Object.assign({}, this.state.errors, {paid: parseFloat(event.target.value) < 0})})
    }

    onChoisePayment(event){
        this.setState({
            order: Object.assign({}, this.state.order, {
                id_payment: event.target.value
            }),
         });
    }

    onChangeValue(event) {
        this.setState({
                order : Object.assign({}, this.state.order, {
                id_state: event.target.value})
            });
    }

    onSuccess(){
        this.setState({
            loading: false,
            completeOrder: true
        })
    }

    render(){
        const { payments, order_states } = this.props.initData;
        const {order, errors, loading, completeOrder} = this.state;
        const { cart, isEditing, order: editingOrder } = this.props;
        return (
            <div className={"payment-form-sale"}>
                {loading ? <Loading/> :
                    completeOrder ?
                            <div>
                                <h4>Order complete</h4>
                            </div>
                            : <div>
                    <div className={"title-popup"}><h3 className="title-form">Complete order</h3></div>
                    <div>
                    <h5 className="total-cart">Total: {this.totalCart}</h5>
                    <div className={ClassNames({'input-group payment': true}, {'has-error': this.state.error})}>
                        <label>Paid : </label>
                        <input type="text" value={order.paid}  onChange={this.onChangePaid}/>
                    </div>
                    <div className="input-group payment">
                        <label>Payment method : </label>
                        <select
                            name="id_state"
                            className={"form-control"}
                            defaultValue={isEditing ? editingOrder.payment : order.id_payment}
                            onChange={this.onChoisePayment.bind(this)}
                        >
                            {payments.map((payment) => (
                                <option value={payment.id} key={payment.id}>
                                    {payment.name}
                                </option>
                            ))}
                        </select>
                    </div>
                    <div
                        className={ClassNames(
                        { "input-group payment": true },
                        { "has-error": errors.id_state }
                        )}
                    >
                        <label>State:</label>
                        <select
                            name="id_state"
                            className={"form-control"}
                            defaultValue={isEditing ? editingOrder.current_status : order.id_state}
                            onChange={this.onChangeValue.bind(this)}
                            >
                            {order_states.map((state, i) => (
                                <option value={state.id} key={i}>
                                    {state.name}
                                </option>
                            ))}
                        </select>
                        <span
                            className={ClassNames(
                            { "help-block": true },
                            { hidden: !errors.id_group }
                            )}
                        >
                                {errors.id_group}
                        </span>
                    </div>
                    <div className="input-group payment">
                        <label>Ship before :</label>
                        <DatePicker
                            showYearDropdown
                            selected={isEditing ? new moment(editingOrder.date_ship) : order.date_ship}
                            onChange={this.onChangeDate.bind(this,"date_ship")}
                            className="form-control"
                        />
                    </div>
                    <button className="btn-complete-pay"  onClick={this.completeOrder}>Complete</button>
                    </div>
                    </div>
                    }
            </div>

        )
    }
}
