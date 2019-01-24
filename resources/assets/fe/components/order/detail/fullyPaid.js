import React, { Component } from 'react';
import * as _ from "lodash";
import {showPrice} from "../../../utility";
import Popup from "reactjs-popup";
import Loading from "../../layout/loading";
import ClassNames from "classnames";
import Api from '../../../api';

export default class FullyPaid extends Component{
    constructor(props){
        super(props);
        let paid = 0;
        for(let i = 0; i < this.props.paidOrder.length; i++){
            paid += parseFloat(this.props.paidOrder[i].paid);
        }
        console.log(this.props);
        this.state = {
            paidOrder: this.props.paidOrder,
            paid: paid,
            unpaid: parseFloat(this.props.totalPaid) - parseFloat(paid),
            newPaid: parseFloat(this.props.totalPaid) - parseFloat(paid),
            payment: this.props.payment,
            showPaidModal: false
        };
        this.onChangePaid = this.onChangePaid.bind(this);
        this.onChoisePayment = this.onChoisePayment.bind(this);
        this.showPaidPopup = this.showPaidPopup.bind(this);
        this.onClosePopUp = this.onClosePopUp.bind(this);
        this.paid = this.paid.bind(this);
    }

    onChangePaid(event){
        this.setState({
            newPaid: (_.isNull( event.target.value.match(/[^0-9.-]/)))
                    ? event.target.value : this.state.newPaid
            })
    }

    onChoisePayment(event){
        this.setState({
            payment: event.target.value
        });
    }

    showPaidPopup(){
        this.setState({showPaidModal: true})
    }

    onClosePopUp(){
        this.setState({showPaidModal: false})
    }

    async paid(){
        if(parseFloat(this.state.newPaid) >= 0){
            this.setState({loading: true});
            try{
                const response = await Api.addPaidOrder({
                    idOrder: this.props.idOrder,
                    newPaid: this.state.newPaid,
                    payment: this.state.payment
                }, this.props.jwt);

                const result = JSON.parse(response.text);
                const payments = this.state.paidOrder;
                const payment = _.first(_.filter(this.props.payments, (p) => p.id == this.state.payment));
                payments.push({
                    paid: this.state.newPaid,
                    payment: payment
                });
                if(result.status){
                    this.setState({
                        showPaidModal: false,
                        loading: false,
                        newPaid: parseFloat(this.state.unpaid) - parseFloat(this.state.newPaid),
                        unpaid: parseFloat(this.state.unpaid) - parseFloat(this.state.newPaid),
                        paidOrder: payments
                    })
                }else{
                    alert('Something went wrong');
                    this.setState({
                        loading: false,
                        showPaidModal: false
                    })
                }
            }catch (e) {
                alert('Something went wrong');
            }
        }
    }

    render() {
        const { payment, unpaid, showPaidModal, loading, newPaid, paidOrder} = this.state;
        return (
            <div>
                <div className="input-group">
                    <label>Total paid:</label>
                    <ul>
                        {paidOrder.map((po, index) => (
                            <li>
                                <span key={index}>{showPrice(po.paid)} - {po.payment.name}</span>
                            </li>
                        ) )}
                    </ul>
                </div>
                {unpaid > 0 ?
                    <div>
                        <label>Unpaid: {showPrice(Math.round(unpaid, 2))}</label>
                        <br/>
                        <button className={'btn btn-default'} onClick={this.showPaidPopup}>Paid</button>
                        <Popup open={showPaidModal} onClose={this.onClosePopUp}>
                            <div className={"payment-form-sale"}>
                                {loading ? <Loading/> :
                                         <div>
                                            <div className={"title-popup"}><h3 className="title-form">Complete order</h3></div>
                                            <div>
                                                <h5 className="total-cart">Unpaid: {showPrice(Math.round(unpaid, 2))}</h5>
                                                <div className={ClassNames({'input-group payment': true}, {'has-error': this.state.error})}>
                                                    <label>Paid : </label>
                                                    <input type="text" value={newPaid}  onChange={this.onChangePaid}/>
                                                </div>
                                                <div className="input-group payment">
                                                    <label>Payment method : </label>
                                                    <select
                                                        name="id_state"
                                                        className={"form-control"}
                                                        defaultValue={payment}
                                                        onChange={this.onChoisePayment.bind(this)}
                                                    >
                                                        {this.props.payments.map((payment) => (
                                                            <option value={payment.id} key={payment.id}>
                                                                {payment.name}
                                                            </option>
                                                        ))}
                                                    </select>
                                                </div>
                                                {this.props.canPaid &&
                                                  <button className="btn-complete-pay"  onClick={this.paid}>Paid</button>
                                                }
                                            </div>
                                        </div>
                                }
                            </div>
                        </Popup>
                    </div>
                    :
                    <button className={'btn btn-success'}>Fully paid</button>
                }
            </div>
        )
    }
}
