import React, { Component } from "react";
import * as _ from "lodash";
import Loading from "../../layout/loading";
import XLSX from "xlsx";
import { parse } from "path";
import {} from "../../../actions/report/order";
import {requestReportPayment} from "../../../actions/report/order";
import {showPrice} from "../../../utility";
import FilterFromTo from "../../helper/filterFromTo";

export default class OrderPaymentReport extends Component {
    constructor(props) {
        super(props);
        this.state = {
            isFetching: true,
            orders: this.props.orders,
            filters: this.props.filters,
        };
        this.export = this.export.bind(this);
        this.onRequestFilter = this.onRequestFilter.bind(this);
        this.onRequestFilterByDateShip = this.onRequestFilterByDateShip.bind(this);
        this.onChangeDate = this.onChangeDate.bind(this);
    }

    componentDidMount() {
        this.props.dispatch(requestReportPayment({jwt: this.props.jwt}));
    }

    componentWillReceiveProps(nextProps) {
            this.setState({
                orders: nextProps.orders,
                filters: nextProps.filters,
                isFetching: false
            });
    }

    onChangeDate(field, date) {
        this.setState({
            filters: Object.assign({}, this.state.filters, {
                [field]: date.format('YYYY-MM-DD 23:59:59')
            })
        });
    }

    onRequestFilter(){
        this.setState({
            isFetching: true
        });
        this.props.dispatch(
            requestReportPayment({
                jwt: this.props.jwt,
                filters: this.state.filters
            })
        );
    }

    onRequestFilterByDateShip() {
        this.setState({
            isFetching: true
        });
        this.props.dispatch(
            requestReportPayment({
                jwt: this.props.jwt,
                filters: this.state.filters,
                dateShip: true
            })
        );
    }

    export() {
        const {orders} = this.state;
        const tHead = [["STT", "Method", "Total order"]];
        _.values(orders).forEach(order => {
            tHead.push([order.payment.id, order.payment.name, showPrice(order.total_order)])
        });

        const wb = XLSX.utils.book_new();
        const wsAll = XLSX.utils.aoa_to_sheet(tHead);
        XLSX.utils.book_append_sheet(wb, wsAll, "Order by payment method");
        XLSX.writeFile(wb, "order_payment_method.xlsx");
    }

    renderReport() {
        const {orders, filters} = this.state;
        return (
            <div>
                <div className="box-header with-border text-center">
                    <h3 className="">Report by payment method</h3>
                </div>
                <div className="filter-report-customer">
                    <div className="filter-report">
                        <FilterFromTo filter={filters} onChangeDate={this.onChangeDate} />
                        <button className="btn-filter" onClick={this.onRequestFilter}> <i className={'fa fa-filter'}></i>Filter</button>
                        <span>              </span>
                        <button className="btn-filter" onClick={this.onRequestFilterByDateShip}> <i className={'fa fa-filter'}></i>Filter by date ship</button>
                    </div>
                    <div className="btn-export-excel">
                        <button onClick={this.export}>Export</button>
                    </div>
                </div>
                <div className="box table-responsive order-report-container order-summary-report">
                    <table className="table table-hover table-bordered" id="sheetjs">
                        <tbody>
                        <tr>
                            <th>STT</th>
                            <th>Method</th>
                            <th>Total order</th>
                        </tr>
                        {orders.map(order => (
                            <tr key={order.payment.id}>
                                <td>{order.payment.id}</td>
                                <td>{order.payment.name}</td>
                                <td>{showPrice(order.total_order)}</td>
                            </tr>
                        ))}
                        </tbody>
                    </table>
                </div>
            </div>
        );
    }

    render() {
        const { isFetching } = this.state;
        if (isFetching) {
            return <Loading />;
        }
        return (
            <div>
                {this.renderReport()}
            </div>
        )
    }
}
