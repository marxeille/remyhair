import React, { Component } from "react";
import * as _ from "lodash";
import Loading from "../../layout/loading";
import XLSX from "xlsx";
import { parse } from "path";
import {requestGetOrderWeft} from "../../../actions/report/order";
import FilterFromTo from "../../helper/filterFromTo";

export default class OrderWeft extends Component {
    constructor(props) {
        super(props);
        this.state = {
            isFetching: true,
            orderDetailsWeft: this.props.orderDetailsWeft,
            jwt: this.props.jwt,
            filters: this.props.filters,
            weftTypes: this.props.weftTypes,
        };
        this.export = this.export.bind(this);
        this.onRequestFilter = this.onRequestFilter.bind(this);
        this.onChangeDate = this.onChangeDate.bind(this);
        this.onRequestFitlerByDateShip = this.onRequestFitlerByDateShip.bind(this);
    }

    componentDidMount() {
        this.props.dispatch(requestGetOrderWeft({jwt: this.props.jwt}));
    }

    componentWillReceiveProps(nextProps) {
            this.setState({
                orderDetailsWeft: nextProps.orderDetailsWeft,
                filters: nextProps.filters,
                weftTypes: nextProps.weftTypes,
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
            requestGetOrderWeft({
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
            requestGetOrderWeft({
                jwt: this.props.jwt,
                filters: this.state.filters,
                dateShip: true
            })
        );
    }

    export() {
        const { orderDetailsWeft, weftTypes} = this.state;
        let tmpWeft = weftTypes.map((type) => type.id);
        const styles = _.filter(this.props.hairStyles,
            (style) => _.includes(tmpWeft, style.id));
        if(orderDetailsWeft){
            const tHead = [["SIZE"]];
            _.values(styles).forEach((style) => {
                _.head(tHead).push(style.name);
            });
            _.values(orderDetailsWeft).forEach((product) => {
                let tmp = [];
                tmp.push(_.head(_.filter(this.props.hairSizes, (size) => size.id == product.id_hair_size)).name);

                styles.forEach((style) => {
                    let target = _.filter(product, (childProduct) => childProduct.id_hair_style == style.id);
                    tmp.push(_.isEmpty(target) ? '0 kg' : _.head(target).total_kg + 'kg' );
                });
                tmp.push(!_.isEmpty(product.total_weft_kg) ? product.total_weft_kg + ' kg' : 0 + ' kg');
                tmp.push(!_.isEmpty(product.total_bulk_kg)  ? product.total_bulk_kg + ' kg' : 0 + ' kg');
                tHead.push(tmp);
            });
            let sum =[];
            sum.push('Tổng');
            styles.map(style => {
                let target = 0;
                {_.values(orderDetailsWeft).map(product => {
                    target += _.sum(_.values(product).map(p => p.id_hair_style == style.id ? parseFloat(p.total_kg) : 0));
                })}
                sum.push(Math.round(target * 100) / 100 + 'kg');
            });
            let weft = 0;
            let bulk = 0;
            _.values(orderDetailsWeft).map(product => {
                weft += !_.isEmpty(product.total_weft_kg) ? parseFloat(product.total_weft_kg) : 0;
                bulk += !_.isEmpty(product.total_bulk_kg) ? parseFloat(product.total_bulk_kg) : 0;
            });
            sum.push(weft + ' kg');
            sum.push(bulk + ' kg');
            tHead.push(sum);
            const wb = XLSX.utils.book_new();
            const wsAll = XLSX.utils.aoa_to_sheet(tHead);
            XLSX.utils.book_append_sheet(wb, wsAll, "WEFT report");
            XLSX.writeFile(wb, "weft-report.xlsx");
        }
    }

    renderWeft() {
        const {orderDetailsWeft, filters, weftTypes} = this.state;
        let styleTmp = _.values(weftTypes).map((type) => type.id);
        const styles = _.filter(this.props.hairStyles,
            (style) => _.includes(styleTmp, style.id));
        let weft = 0;
        let bulk = 0;
        _.values(orderDetailsWeft).map(product => {
            weft += !_.isEmpty(product.total_weft_kg) ?  parseFloat(product.total_weft_kg) : 0 ;
            bulk += !_.isEmpty(product.total_bulk_kg) ? parseFloat(product.total_bulk_kg) : 0 ;
        });
        return (
            <div>
                <div className="box-header with-border text-center">
                    <h3 className="">WEFT report</h3>
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
                            {styles.map((style) => (
                                <th>{style.name}</th>
                            ))}
                            <th>Color</th>
                            <th>Bulk</th>
                        </tr>
                        {_.values(orderDetailsWeft).map(product =>
                            <tr>
                                <td>
                                    {_.head(_.filter(this.props.hairSizes, (size) => size.id == product.id_hair_size)).name}
                                </td>
                                {styles.map(style => {
                                    let target = _.filter(product['report'], (childProduct) => childProduct.id_hair_style == style.id);
                                    return (<td>{_.isEmpty(target) ? '0 kg' : _.head(target).total_kg + 'kg' }</td>)
                                })}
                                <td>{!_.isEmpty(product.total_weft_kg) ? product.total_weft_kg + ' kg' : 0 + ' kg'}</td>
                                <td>{!_.isEmpty(product.total_bulk_kg)  ? product.total_bulk_kg + ' kg' : 0 + ' kg'}</td>
                            </tr>
                        )}
                        <tr>
                            <td>Tổng</td>
                            { styles.map(style => {
                                let target = 0;
                                {_.values(orderDetailsWeft).map(product => {
                                    target += _.sum(_.values(product.report).map(p => p.id_hair_style == style.id ? parseFloat(p.total_kg) : 0));
                                })}
                                return (<td>{Math.round(target * 100) / 100 + 'kg'}</td>)
                            })}
                            <td>{weft + ' kg'}</td>
                            <td>{bulk + ' kg'}</td>
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
