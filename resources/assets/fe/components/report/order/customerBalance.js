import React, { Component } from "react";
import * as _ from "lodash";
import Loading from "../../layout/loading";
import XLSX from "xlsx";
import { parse } from "path";
import {requestReportCustomerBalance} from "../../../actions/report/order";
import {showPrice} from "../../../utility";
import FilterFromTo from '../../helper/filterFromTo';

export default class CustomerBalance extends Component {
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
        this.props.dispatch(requestReportCustomerBalance({jwt: this.props.jwt}));
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
            requestReportCustomerBalance({
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
            requestReportCustomerBalance({
                jwt: this.props.jwt,
                filters: this.state.filters,
                dateShip: true
            })
        );
    }

    export() {
        const {orders} = this.state;
        const tHead = [["Name", "Email", "Phone", "Total order", "Total discount", "Balance"]];
        _.values(orders).forEach(order => {
            tHead.push([order.customer.full_name, order.customer.email, order.customer.phone, showPrice(order.total_order), showPrice(order.total_discount), showPrice(order.customer.customer_balance)])
        });

        const wb = XLSX.utils.book_new();
        const wsAll = XLSX.utils.aoa_to_sheet(tHead);
        XLSX.utils.book_append_sheet(wb, wsAll, "Order by customer balance");
        XLSX.writeFile(wb, "order_customer_balance.xlsx");
    }

    renderReport() {
        const {orders, filters} = this.state;
        return (
            <div>
                <div className="box-header with-border text-center">
                    <h3 className="">Customer report</h3>
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
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Total order</th>
                            <th>Total discount</th>
                            <th>Balance</th>
                        </tr>
                        {orders.map(order => (
                            <tr key={order.customer.id}>
                                <td>{order.customer.full_name}</td>
                                <td>{order.customer.email}</td>
                                <td>{order.customer.phone}</td>
                                <td>{showPrice(order.total_order)}</td>
                                <td>{showPrice(order.total_discount)}</td>
                                <td>{showPrice(order.customer.customer_balance)}</td>
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
