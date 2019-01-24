import React, { Component } from "react";
import * as _ from "lodash";
import Loading from "../../layout/loading";
import DatePicker from "react-datepicker";
import moment from "frozen-moment";
import XLSX from "xlsx";
import { parse } from "path";
import {requestGetOrderSummary} from "../../../actions/report/order";
import FilterFromTo from "../../helper/filterFromTo";

export default class OrderSummary extends Component {
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

    componentDidMount() {
        this.props.dispatch(requestGetOrderSummary({jwt: this.props.jwt}));
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
            requestGetOrderSummary({
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
            requestGetOrderSummary({
                jwt: this.props.jwt,
                filters: this.state.filters,
                dateShip: true
            })
        );
    }

    export() {
        const {orders} = this.state;
        const tHead = [["Mã đơn hàng", "SUPPORTER", "CUSTOMER", "COUNTRY", "Total KG", "SIZE", "TYPE", "HAIR STYLE", "HAIR COLOR", "DRAWN","KG","Note Order","FILE Ảnh","Date Order","Date Ship","Status Order","Reason"]];
        _.values(orders).forEach(order => {
            let orderDetailNum = _.size(order.order_detail);
            order.order_detail.forEach((orderDetail, index) => {
                if(index + 1 == orderDetailNum){
                    tHead.push([
                       order.id,
                       order.employee.name,
                       order.customer.full_name,
                       order.address.address,
                       order.total_kg,
                        orderDetail.hair_size.name,
                        orderDetail.hair_type.name,
                        orderDetail.hair_style.name,
                        orderDetail.hair_color.name,
                        orderDetail.hair_draw.name,
                        orderDetail.kg,
                        order.note,
                        order.img,
                        order.created_at,
                        order.date_ship,
                        order.order_status.name,
                        order.reason,
                    ]);
                }else{
                    tHead.push([
                        order.id,
                        '',
                        '',
                        '',
                        '',
                        orderDetail.hair_size.name,
                        orderDetail.hair_type.name,
                        orderDetail.hair_style.name,
                        orderDetail.hair_color.name,
                        orderDetail.hair_draw.name,
                        orderDetail.kg,
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                ]);}
            });
        });

        const wb = XLSX.utils.book_new();
        const wsAll = XLSX.utils.aoa_to_sheet(tHead);
        XLSX.utils.book_append_sheet(wb, wsAll, "Order Stats");
        XLSX.writeFile(wb, "order_summary.xlsx");
    }

    renderSummary() {
        const {orders, filters} = this.state;
        return (
            <div>
                <div className="box-header with-border text-center">
                    <h3 className="">Order summary</h3>
                </div>
                <div className="filter-report-customer">
                    <div className="filter-report">
                        <FilterFromTo filter={filters} onChangeDate={this.onChangeDate} />
                        <button className="btn-filter" onClick={this.onRequestFilter}> <i className={'fa fa-filter'}></i>Filter</button>
                        <span>              </span>
                        <button className="btn-filter" onClick={this.onRequestFitlerByDateShip}> <i className={'fa fa-filter'}></i>Filter by date ship</button>
                    </div>
                    <div className="btn-export-excel">
                        <button onClick={this.export}>Export</button>
                    </div>
                </div>
                <div className="box table-responsive order-report-container order-summary-report">
                    <table className="table table-hover table-bordered" id="sheetjs">
                        <tbody>
                        <tr>
                            <th colSpan="5">I. Thông tin đơn hàng</th>
                            <th colSpan="6">II. Đơn hàng chi tiết</th>
                            <th colSpan="2">III. Chú ý khi làm hàng</th>
                            <th colSpan="4">IV. Tình trạng đơn hàng</th>
                        </tr>
                        <tr>
                            <td>#</td>
                            <td>SUPPORTER</td>
                            <td>CUSTOMER</td>
                            <td>ADDRESS</td>
                            <td>Total KG</td>
                            <td>SIZE</td>
                            <td>TYPE</td>
                            <td>HAIR STYLE</td>
                            <td>HAIR COLOR</td>
                            <td>DRAWN</td>
                            <td>KG</td>
                            <td>Note Order</td>
                            <td>FILE Ảnh</td>
                            <td>Date Order</td>
                            <td>Date Ship</td>
                            <td>Status Order</td>
                            <td>Reason</td>
                        </tr>
                        {orders.map(order => (
                            <tr key={order.id}>
                                <td>{order.id}</td>
                                <td>{order.employee.name}</td>
                                <td>{order.customer.full_name}</td>
                                <td>{order.address.address}</td>
                                <td>{order.total_kg}</td>
                                <td>
                                    <table>
                                        {order.order_detail.map(orderDetail => (
                                            <tr key={orderDetail.id}>
                                                <td>{orderDetail.hair_size.name}</td>
                                            </tr>
                                        ))}
                                    </table>
                                </td>
                                <td>
                                    <table>
                                        {order.order_detail.map(orderDetail => (
                                            <tr key={orderDetail.id}>
                                                <td>{orderDetail.hair_type.name}</td>
                                            </tr>
                                        ))}
                                    </table>
                                </td>
                                <td>
                                    <table>
                                        {order.order_detail.map(orderDetail => (
                                            <tr key={orderDetail.id}>
                                                <td>{orderDetail.hair_style.name}</td>
                                            </tr>
                                        ))}
                                    </table>
                                </td>
                                <td>
                                    <table>
                                        {order.order_detail.map(orderDetail => (
                                            <tr key={orderDetail.id}>
                                                <td>{orderDetail.hair_color.name}</td>
                                            </tr>
                                        ))}
                                    </table>
                                </td>
                                <td>
                                    <table>
                                        {order.order_detail.map(orderDetail => (
                                            <tr key={orderDetail.id}>
                                                <td>{orderDetail.hair_draw.name}</td>
                                            </tr>
                                        ))}
                                    </table>
                                 </td>
                                <td>
                                    <table>
                                        {order.order_detail.map(orderDetail => (
                                            <tr key={orderDetail.id}>
                                                <td>{orderDetail.kg}</td>
                                            </tr>
                                        ))}
                                    </table>
                                 </td>
                                <td>{order.note ? order.note : ''}</td>
                                <td>{order.img && <img src={order.img} alt="order img"/>}</td>
                                <td>{order.created_at}</td>
                                <td>{order.date_ship}</td>
                                <td>{order.order_status.name}</td>
                                <td>{order.reason ? order.reason : ''}</td>
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
                {this.renderSummary()}
            </div>
        )
    }
}
