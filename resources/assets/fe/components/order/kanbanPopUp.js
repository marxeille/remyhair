import React, {Component} from 'react';
import {renderAddress} from "../../utility";
import DatePicker from "react-datepicker/es";
import moment from "frozen-moment";
import {showPrice} from '../../utility';
import SaleMan from "./detail/saleman";
import Customer from "./detail/customer";
import Products from "./detail/products";
import Summary from "./detail/summary";
import Api from '../../api';
import Loading from "../layout/loading";
import FullyPaid from "./detail/fullyPaid";

export default class OrderKanbanPopup extends Component{
    constructor(props){
        super(props);
        this.state = {
            detail: props.detail,
            note: props.detail.note,
            reason: props.detail.reason,
            date_ship: props.detail.date_ship,
            isFetching: false,
        };
        this.onChangeValue = this.onChangeValue.bind(this);
        this.update = this.update.bind(this);
        this.archive = this.archive.bind(this);
    }

    onChangeDate(field, date) {
        this.setState({
            [field]: date.format('YYYY-MM-DD 23:59:59')
        });
    }

    onChangeValue(event){
        this.setState({
            [event.target.name]: event.target.value
        });
    }

    async update(){
        this.setState({
            loading: true
        });
        try{
            const response = await Api.requestUpdateOrder(this.props.jwt, {
                id: this.state.detail.id,
                note: this.state.note,
                date_ship: new moment(this.state.date_ship).format('YYYY-MM-DD'),
                reason: this.state.reason
            });
            const result = JSON.parse(response.text);
            result.status ? this.setState({
                loading: false
            }) : alert('some thing went wrong');
        }catch(e){
            alert('some thing went wrong');
        }
    }

    archive(){
        if(confirm('Archive?')){
            this.props.archive();
        }
    }

    render(){
        const {detail, loading} = this.state;
        const { employee, customer, address, order_detail, total_shipping, total_discount, paid_order, total_payment_fee } = detail;
        const { carriers, payments } = this.props.env;
        const {employee: currentEmployee} = this.props;
        return(
          <div className="kanban-popup ">
              {loading ? <Loading />
                    : <div>
                      <div className="row invoice-info">
                          <SaleMan employee={employee}/>
                          <Customer customer={customer} address={address} env={this.props.env}/>
                          <div className="col-sm-4 invoice-col">
                              <b>Order #{`${detail.id}`}</b><br/>
                              <span><strong>{'Date ship:'}</strong> </span>
                              <div className="filter-from">
                                  <div className="datePicker">
                                      <DatePicker
                                          showYearDropdown
                                          selected={this.state.date_ship ? moment(this.state.date_ship) : null}
                                          onChange={this.onChangeDate.bind(this, 'date_ship')}
                                          className="form-control"
                                          name={'date_ship'}
                                      />
                                  </div>
                              </div>
                          </div>
                      </div>
                      <Products orderDetail={order_detail} env={this.props.env}/>
                      <div className="">
                          <div>
                              <div className="cart-summary" >
                                  <div className="input-group">
                                  <label>Subtotal:</label>
                                  <p>{showPrice(detail.sub_total)}</p>
                                  </div>
                                  <div className="input-group">
                                  <label>Carrier:</label>
                                  <p>{_.first(_.filter(carriers, (c) => c.id == parseInt(detail.id_carrier))).name}</p>
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
                                  <p>{showPrice(detail.total_paid)}</p>
                                  </div>
                              </div>
                              <div className="input-group">
                                  <FullyPaid totalPaid={detail.total_paid} canPaid={detail.type == 0} payments={payments} paidOrder={detail.paid_order} payment={detail.payment} idOrder={detail.id} jwt={this.props.jwt} />
                              </div>
                          </div>
                          <div>
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
                          </div>
                          {currentEmployee.id == detail.id_employee || currentEmployee.id_group == 1 ?
                              <div className="btn-view-popup">
                                  <button className={'btn-save'} onClick={this.archive}>Archive</button>
                                  <button className={'btn-save'} onClick={this.update}>Update</button>
                              </div>
                              : <div></div>
                          }
                      </div>
                  </div>
              }

          </div>
        );
    }
}
