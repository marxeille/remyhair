import React, { Component } from "react";
import * as _ from "lodash";
import Loading from "../../layout/loading";
import XLSX from "xlsx";
import { parse } from "path";
import {requestOrderClosure} from "../../../actions/report/order";
import FilterFromTo from "../../helper/filterFromTo";

export default class OrderClosure extends Component {
    constructor(props) {
        super(props);
        this.state = {
            isFetching: true,
            orders: this.props.orders,
            jwt: this.props.jwt,
            filters: this.props.filters,
            closureTypes: this.props.closureTypes,
        };
        this.export = this.export.bind(this);
        this.onRequestFilter = this.onRequestFilter.bind(this);
        this.onRequestFitlerByDateShip = this.onRequestFitlerByDateShip.bind(this);
        this.onChangeDate = this.onChangeDate.bind(this);
    }

    componentDidMount() {
        this.props.dispatch(requestOrderClosure({jwt: this.props.jwt}));
    }

    componentWillReceiveProps(nextProps) {
            this.setState({
                orders: nextProps.orders,
                filters: nextProps.filters,
                closureTypes: nextProps.closureTypes,
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
            requestOrderClosure({
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
            requestOrderClosure({
                jwt: this.props.jwt,
                filters: this.state.filters,
                dateShip: true
            })
        );
    }

    export() {
        const {orders, closureTypes} = this.state;
        const types = _.filter(this.props.hairTypes,
            (type) => !_.isEmpty(_.filter(closureTypes, (closure) => closure.id == type.id)));
        if(orders){
            const tHead = [["SIZE"]];
            _.values(types).forEach((style) => {
                _.head(tHead).push(style.name);
            });
            _.values(orders).forEach((product) => {
                let tmp = [];
                tmp.push(_.head(_.filter(this.props.hairSizes, (size) => size.id == _.head(product).id_hair_size)).name);
                types.forEach((type) => {
                    let target = _.filter(product, (childProduct) => childProduct.id_hair_type == type.id);
                    tmp.push(_.isEmpty(target) ? '0 kg' : _.head(target).total_kg + 'kg' );
                });
                tHead.push(tmp);
            });

            let sum =[];
            sum.push('Tổng');
            types.map(type => {
                let target = 0;
                {_.values(orders).map(product => {
                    target += _.sum(_.values(product).map(p => p.id_hair_type == type.id ? parseFloat(p.total_kg) : 0));
                })}
                sum.push(Math.round(target * 100) / 100 + 'kg');
            });
            tHead.push(sum);
            const wb = XLSX.utils.book_new();
            const wsAll = XLSX.utils.aoa_to_sheet(tHead);
            XLSX.utils.book_append_sheet(wb, wsAll, "Closure Summary");
            XLSX.writeFile(wb, "closure-report.xlsx");
        }
    }

    renderWeft() {
        const {filters, orders, closureTypes} = this.state;
        const types = _.filter(this.props.hairTypes,
            (type) => !_.isEmpty(_.filter(closureTypes, (closure) => closure.id == type.id)));
        return (
            <div>
                <div className="box-header with-border text-center">
                    <h3 className="">CLOSURE, FRONTAL SUMMARY</h3>
                </div>
                <div className="filter-report-customer">
                    <div className="filter-report">
                        <FilterFromTo filter={filters} onChangeDate={this.onChangeDate} />
                        <button className="btn-filter" onClick={this.onRequestFilter.bind(this)}> <i className={'fa fa-filter'}></i>Filter</button>
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
                            {types.map((type) => (
                                <th>{type.name}</th>
                            ))}
                        </tr>
                        {_.values(orders).map(closure =>
                            <tr>
                                <td>
                                    {_.head(_.filter(this.props.hairSizes, (size) => size.id == _.head(closure).id_hair_size)).name}
                                </td>
                                {types.map(type => {
                                    let target = _.filter(closure, (childCclosure) => childCclosure.id_hair_type == type.id);
                                    return (<td>{_.isEmpty(target) ? '0 kg' : _.head(target).total_kg + 'kg' }</td>)
                                })}
                            </tr>
                        )}
                        <tr>
                            <td>Tổng</td>
                            {types.map(size => {
                                let target = 0;
                                {_.values(orders).map(product => {
                                    target += _.sum(_.values(product).map(p => p.id_hair_type == size.id ? parseFloat(p.total_kg) : 0));
                                })}
                                return (<td>{Math.round(target * 100) / 100 + 'kg' }</td>)
                            })}
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
                {this.renderWeft()}
            </div>
        )
    }
}
