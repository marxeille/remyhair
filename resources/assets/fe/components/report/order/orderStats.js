import React, { Component } from "react";
import * as _ from "lodash";
import Loading from "../../layout/loading";
import DatePicker from "react-datepicker";
import moment from "frozen-moment";
import XLSX from "xlsx";
import { parse } from "path";
import {requestGetOrderStats} from "../../../actions/report/order";
import FilterFromTo from "../../helper/filterFromTo";

export default class OrderStats extends Component {
    constructor(props) {
        super(props);
        this.state = {
            isFetching: true,
            orders: this.props.orders,
            filters: this.props.filters,
        };
        this.export = this.export.bind(this);
        this.onRequestFilter = this.onRequestFilter.bind(this);
        this.onRequestFitlerByDateShip = this.onRequestFitlerByDateShip.bind(this);
        this.onChangeDate = this.onChangeDate.bind(this);
    }

    componentWillMount() {
        this.props.dispatch(requestGetOrderStats({jwt: this.props.jwt}));
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

    onRequestFilter() {
        this.setState({
            isFetching: true
        });
        this.props.dispatch(
            requestGetOrderStats({
                jwt: this.props.jwt,
                filters: this.state.filters
            })
        );
    }

    onRequestFitlerByDateShip() {
        this.setState({
            isFetching: true
        });
        this.props.dispatch(
            requestGetOrderStats({
                jwt: this.props.jwt,
                filters: this.state.filters,
                dateShip: true
            })
        );
    }

    export() {
        const {orders, filters} = this.state;
        const {orderStatus, hairSizes} = this.props;
        let total = 0;
        const tHead = [["SIZE"]];
        _.values(orderStatus).forEach((status) => {
            _.head(tHead).push(status.name);
        });
        _.head(tHead).push("Total");
        _.values(orders).forEach((order) => {
            let tmp = [];
            tmp.push(_.head(_.filter(hairSizes, (size) => size.id == _.head(order).id_hair_size)).name);
            orderStatus.forEach((status) => {
                let target = _.filter(order, (childOrder) => childOrder.status == status.id);
                tmp.push(_.isEmpty(target) ? '0 kg' : _.head(target).total_kg + 'kg' );
            });
            tHead.push(tmp);
        });

        let sum =[];
        sum.push('Total');
        orderStatus.map(status => {
            let target = 0;
            {_.values(orders).map(order => {
                target += _.sum(_.values(order).map(o => o.status == status.id ? parseFloat(o.total_kg) : 0));
            })}
            total += Math.round(target * 100) / 100;
            sum.push(Math.round(target * 100) / 100 + 'kg');
        });
        sum.push(total + 'kg');
        tHead.push(sum);
        tHead.push([`${moment(filters.from).format('DD-MM-YY')} -> ${moment(filters.to).format('DD-MM-YY')}`]);
        const wb = XLSX.utils.book_new();
        const wsAll = XLSX.utils.aoa_to_sheet(tHead);
        XLSX.utils.book_append_sheet(wb, wsAll, "Order Stats");
        XLSX.writeFile(wb, "order_stats.xlsx");
    }

    renderStats() {
        const {orders, filters} = this.state;
        const {orderStatus, hairSizes} = this.props;
        let total = 0;
        return (
            <div>
                <div className="box-header with-border text-center">
                    <h3 className="">Order stats</h3>
                </div>
                <div className="filter-report-customer">
                    <div className="filter-report">
                        <FilterFromTo filter={filters} onChangeDate={this.onChangeDate}/>
                        <button className="btn-filter" onClick={this.onRequestFilter}> <i className={'fa fa-filter'}></i>Filter</button>
                        <span>              </span>
                        <button className="btn-filter" onClick={this.onRequestFitlerByDateShip}> <i className={'fa fa-filter'}></i>Filter by date ship</button>
                    </div>
                    <div className="btn-export-excel">
                        <button onClick={this.export}>Export</button>
                    </div>
                </div>
                <div className="box table-responsive order-report-container">
                    <table className="table table-hover table-bordered" id="sheetjs">
                        <tbody>
                        <tr>
                            <th>SIZE</th>
                            {orderStatus.map((status) => (
                                <th key={status.id}>{status.name}</th>
                            ))}
                            <th>Total</th>
                        </tr>
                        {_.values(orders).map((order, index) =>
                            <tr key={index}>
                                <td>
                                    {_.head(_.filter(hairSizes, (size) => size.id == _.head(order).id_hair_size)).name}
                                </td>
                                {orderStatus.map(status => {
                                    let target = _.filter(order, (childOrder) => childOrder.status == status.id);
                                    return (<td key={status.id}>{_.isEmpty(target) ? '0 kg' : _.head(target).total_kg + 'kg' }</td>)
                                })}
                            </tr>
                        )}
                        <tr>
                            <td>Total</td>
                            {orderStatus.map(status => {
                                let target = 0;
                                {_.values(orders).map(order => {
                                    target += _.sum(_.values(order).map(o => o.status == status.id ? parseFloat(o.total_kg) : 0));
                                })}
                                total +=  Math.round(target * 100) / 100;
                                return (<td key={status.id}>{Math.round(target * 100) / 100 + 'kg' }</td>)
                            })}
                            <td>{total} kg</td>
                        </tr>
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
                {this.renderStats()}
            </div>
        )
    }
}
