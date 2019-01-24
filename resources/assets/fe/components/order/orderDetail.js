import React, { Component } from 'react';
import {requestAddNewPaidOrder, requestChangeOrderState, requestOrder, editOrder} from "../../actions/order";
import * as _ from 'lodash';
import Loading from "../layout/loading";
import {hasRole} from "../../utility";
import moment from "frozen-moment";
import DatePicker from "react-datepicker";
import SaleMan from "./detail/saleman";
import Customer from "./detail/customer";
import Products from "./detail/products";
import Summary from "./detail/summary";
import FullyPaid from "./detail/fullyPaid";
import Api from '../../api';
import {receiveInitCart} from "../../actions/order/cart";

export default class OrderDetail extends Component{
    constructor(props){
        super(props);
        this.state = {
            order: {},
            note: '',
            reason: '',
            date_ship: '',
            isFetching: true,
            newPaid: {
                paid: '',
            }
        };
        this.changeState = this.changeState.bind(this);
        this.completePayment = this.completePayment.bind(this);
        this.onChangePaid = this.onChangePaid.bind(this);
        this.onChoisePayment = this.onChoisePayment.bind(this);
        this.onChangeValue = this.onChangeValue.bind(this);
        this.onChangeDate = this.onChangeDate.bind(this);
        this.handleUpdate = this.handleUpdate.bind(this);
        this.handleEditOrder = this.handleEditOrder.bind(this);
    }

    componentWillMount(){
        this.props.dispatch(requestOrder({jwt: this.props.jwt, id: this.props.match.params.id}));
    }

    componentWillReceiveProps(props){
        this.setState({
            isFetching: false,
            order: props.order,
            note: props.order.note,
            reason: props.order.reason,
            date_ship: props.order.date_ship,
            newPaid: {
                paid: '',
            }
        })
    }

    async handleEditOrder(){
        if(hasRole('edit-order/get-cart', this.props.actions)){
            this.setState({
                isFetching: true
            });
            try{
                const response = await Api.initEditCart({
                    idOrder: this.state.order.id,
                    idCart: this.state.order.id_cart
                }, this.props.jwt);
                const result = JSON.parse(response.text);
                result.status ? this.props.dispatch(receiveInitCart(result.data)) : alert('Something went wrong');
                this.props.history.push('/sale')
            }catch(err){
                alert('Something went wrong');
            }
        }else{
            alert('You have no permission')
        }
    }

    changeState(event){
        const order = Object.assign({}, this.state.order, {
            current_status: event.target.value
        });
        this.setState({
            isFetching: true,
            order:order
        });
        this.props.dispatch(requestChangeOrderState({jwt: this.props.jwt, order: order}));
    }

    onChangePaid(event){
        this.setState({
            newPaid: Object.assign({}, this.state.newPaid, {
                paid:  (_.isNull( event.target.value.match(/[^0-9.-]/))) && event.target.value <= parseFloat(Number(this.state.order.total_unpaid.replace(/[^0-9.-]+/g,"")))
                    ? event.target.value : this.state.newPaid.paid
            }),
            errors: Object.assign({}, this.state.errors, {paid: !event.target.value})})
    }

    completePayment(){
        const { newPaid, order } = this.state;
        if(!_.isEmpty(this.state.order.total_unpaid) && newPaid.paid){
            if(!newPaid.id_payment){
                newPaid.id_payment = _.first(this.props.env.payments).id;
                order.new_paid = newPaid;
                this.props.dispatch(requestAddNewPaidOrder({jwt: this.props.jwt, order: order}));
            }
        }
    }

    onChoisePayment(event){
        this.setState({
            newPaid: Object.assign({}, this.state.newPaid, {
                id_payment: event.target.value
            }),
        });
    }

    onChangeValue(event){
        this.setState({
            [event.target.name]: event.target.value
        });
    }

    onChangeDate(field, date) {
        this.setState({
                [field]: date.format('YYYY-MM-DD 23:59:59')
        });
    }

    handleUpdate(type = null) {
        const {note, date_ship, reason, order} = this.state;
        let data = {
            "note": note,
            "reason": reason,
            "date_ship": date_ship,
            "id_order": order.id,
            "type": type
        }
        if (confirm("Do you want to update the order ?")) {
            this.setState({
                isFetching: true
            });
            this.props.dispatch(editOrder({jwt: this.props.jwt, data: data}));
        }
        
    }


    render(){
        const { isFetching, order } = this.state;
        const { employee, customer, address, order_detail } = order;
        const { order_states, payments } = this.props.env;

        if(isFetching) return <Loading />;
        return(
            _.isEmpty(order) ?
                    <div>
                        <h4>Order not found!</h4>
                    </div>
                :
                <div>
                    <section className="invoice">
                        <div className="row">
                            <div className="col-xs-12">
                                <h2 className="page-header">
                                    <i className="fa fa-globe"></i> Order: #{`${order.id}`}
                                    <small className="pull-right">Date: {new moment(order.created_at).format('MM/DD/YYYY')}</small>
                                </h2>
                            </div>
                        </div>
                        <div className="row invoice-info">
                            <SaleMan employee={employee} />
                            <Customer customer={customer} address={address} env={this.props.env} />
                            {hasRole('edit-order/get-cart', this.props.actions) && order.type != 1 && order.type != 2  &&
                            <button type="button" onClick={this.handleEditOrder} className="btn btn-success">
                                <i className="fa fa-credit-card"></i> Edit
                            </button>
                            }
                        </div>
                        <Products orderDetail={order_detail} env={this.props.env}/>
                        <div className="row">
                            <div className="col-xs-6">
                                <p className="text-muted well well-sm no-shadow">
                                    <label>{'Date ship'}</label>    
                                    <DatePicker
                                        showYearDropdown
                                        selected={ this.state.date_ship ? moment(this.state.date_ship) : null}
                                        onChange={this.onChangeDate.bind(this, 'date_ship')}
                                        className="form-control"
                                        name={'date_ship'}
                                    />
                                </p>
                                <p className="text-muted well well-sm no-shadow">
                                    <label>Note</label>    
                                    <textarea 
                                        className="form-control"
                                        name={'note'}
                                        placeholder={'Enter note'}
                                        defaultValue={this.state.note}
                                        onChange={this.onChangeValue.bind(this)} 
                                    />
                                </p>
                                <p className="text-muted well well-sm no-shadow">
                                    <label>Reason</label>       
                                    <textarea 
                                        className="form-control"
                                        name={'reason'}
                                        placeholder={'Enter reason'}
                                        defaultValue={this.state.reason}
                                        onChange={this.onChangeValue.bind(this)} 
                                    />
                                </p>
                                {order.img && <img src={order.img} alt="img" className="order-detail-img"/>}
                            </div>
                            <div className="col-xs-6">
                                <div className="subdetailOrder">
                                    <Summary order={order} env={this.props.env} />
                                    <FullyPaid totalPaid={order.total_paid} canPaid={order.type == 0} payments={payments} paidOrder={order.paid_order} payment={order.payment} idOrder={order.id} jwt={this.props.jwt} />
                                    <div className="input-group">
                                        <label>Order state:</label>
                                            <select className={'form-control select-state'} name="id_state" defaultValue={order.current_status} onChange={this.changeState}>
                                                {order_states.map((os, index) => (
                                                    <option value={os.id} key={index}>{os.name}</option>
                                                ))}
                                            </select>
                                    </div>
                                    {
                                        order.type > 0  ? null :
                                        <div className="input-group">
                                            <button type="button" onClick={this.handleUpdate.bind(this,'update')} className="btn btn-success btn-complete-payment">
                                                <i className="fa fa-credit-card"></i> Update
                                            </button>
                                        </div>
                                    }
                                        
                                        <div className="input-group">
                                        {
                                            order.type == 2 ? null :  
                                            <button type="button" onClick={this.handleUpdate.bind(this,'cancel')} className="btn btn-danger btn-complete-payment">
                                                <i className="fa fa-credit-card"></i> Cancel
                                            </button>
                                        }
                                        {
                                            order.type == 1 ? null :
                                            <button type="button" onClick={this.handleUpdate.bind(this,'refund')} className="btn btn-warning btn-complete-payment">
                                                <i className="fa fa-credit-card"></i> Refund
                                            </button>
                                        }
                                        </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
        )
    }

}
