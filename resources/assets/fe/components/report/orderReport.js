import React, { Component } from "react";
import ClassNames from "classnames";
import * as _ from "lodash";
import {
    requestOrderFilter,
    requestGetOrderList, requestGetTotalProductList, requestProductFilter, requestGetClosureList, requestClosureFilter
} from "../../actions/report/order";
import Loading from "../layout/loading";
import Pagination from "react-js-pagination";
import DatePicker from "react-datepicker";
import moment from "frozen-moment";
import Api from "../../api";
import XLSX from "xlsx";
import { parse } from "path";

export default class OrderReport extends Component {
    constructor(props) {
        super(props);
        this.state = {
            isFetching: true,
            orderStatus: this.props.orderStatus,
            orders: this.props.orders,
            pageLimit: this.props.pageLimit,
            currentPage: this.props.currentPage,
            jwt: this.props.jwt,
            totalItems: this.props.totalItems,
            itemsPerPage: this.props.itemsPerPage,
            filters: this.props.filters,
            actions: this.props.actions,
            products: this.props.products,
            weftTypes: this.props.weftTypes,
        };
        this.handlePageChange = this.handlePageChange.bind(this);
        this.onHandleSorting = this.onHandleSorting.bind(this);
        this.handleProductPageChange = this.handleProductPageChange.bind(this);
        this.onExport = this.onExport.bind(this);

    }

    componentWillMount() {
            this.props.dispatch(requestGetOrderList(this.props.jwt));
            this.props.dispatch(requestGetTotalProductList(this.props.jwt));
            this.props.dispatch(requestGetClosureList(this.props.jwt));
    }

    componentWillReceiveProps(nextProps) {
        if (nextProps.orders) {
            this.setState({
                orders: nextProps.orders,
                currentPage: nextProps.currentPage,
                pageLimit: nextProps.pageLimit,
                itemsPerPage: nextProps.itemsPerPage,
                totalItems: nextProps.totalItems,
                filters: nextProps.filters,
                isFetching: false
            });
        }

        if (nextProps.products) {
            this.setState({
                products: nextProps.products,
                weftTypes: nextProps.weftTypes,
                isFetching: false,
                productFilters: nextProps.productFilters,
                productPagination: nextProps.productPagination,
            });
        }

        if (nextProps.closures) {
            this.setState({
                closures: nextProps.closures,
                closureTypes: nextProps.closureTypes,
                isFetching: false,
                closureFilters: nextProps.closureFilters,
            });
        }
    }

    handlePageChange(pageNumber) {
        if (pageNumber) {
            this.setState({
                isFetching: true
            });
            this.props.dispatch(
                requestOrderFilter({
                    jwt: this.state.jwt,
                    page: pageNumber,
                    filters: this.state.filters
                })
            );
        }
    }

    handleProductPageChange(pageNumber) {
        if (pageNumber) {
            this.setState({
                isFetching: true
            });
            this.props.dispatch(
                requestProductFilter({
                    jwt: this.state.jwt,
                    filters: {type: 'weft', ...this.state.productFilters, page_number: pageNumber}
                })
            );
        }
    }

    onHandleSorting(field, sortBy) {
        const filters = this.props.filters;
        _.each(filters, (f, k) => {
            if (k != field && k != "from" && k != "to") {
                f.sort_by = "";
            }
        });
        filters[field].sort_by = sortBy == "DESC" ? "ASC" : "DESC";
        this.setState({
            filters: filters
        });
        this.props.dispatch(
            requestOrderFilter({
                jwt: this.state.jwt,
                page: this.state.currentPage,
                filters: filters
            })
        );
    }

    onChangeDate(field, date) {
        this.setState({
            filters: Object.assign({}, this.state.filters, {
                [field]: date.format('YYYY-MM-DD 23:59:59')
            })
        });
    }

    onRequestFitler() {
        this.setState({
            isFetching: true
        });
        this.props.dispatch(
            requestOrderFilter({
                jwt: this.state.jwt,
                page: this.state.currentPage,
                filters: this.state.filters
            })
        );
    }

    onRequestProductFitler() {
        this.setState({
            isFetching: true
        });
            this.props.dispatch(
                requestProductFilter({
                    jwt: this.state.jwt,
                    filters: {type: 'weft', ...this.state.filters}
                })
            );
    }

    onRequestClosureFitler() {
        this.setState({
            isFetching: true
        });
            this.props.dispatch(
                requestClosureFilter({
                    jwt: this.state.jwt,
                    filters: {type: 'closure', ...this.state.filters}
                })
            );
    }

    onRequestFitlerByDateShip() {
        this.setState({
            isFetching: true
        });
        this.props.dispatch(
            requestOrderFilter({
                jwt: this.state.jwt,
                page: this.state.currentPage,
                filters: this.state.filters,
                dateShip: true
            })
        );
    }

    onExport() {
        
        const { orders, orderStatus, isFetching } = this.state;
        let statsHead;
        if(!_.isEmpty(orderStatus) && !isFetching) {
            statsHead = orderStatus.map((head) =>
                head
            )
        }
        statsHead.unshift("Size");
        statsHead.push("Total");
        const tHead = [
            statsHead
        ];
        
        _.values(orders.stats).forEach(item => {
            let tBody = [];
            tBody.push(item.name);
            _.values(item.status).map((o) => (
                tBody.push(o.kg)
            ));
            tHead.push(tBody);
        });
        
        const wb = XLSX.utils.book_new();
        const wsAll = XLSX.utils.aoa_to_sheet(tHead);
        XLSX.utils.book_append_sheet(wb, wsAll, "Order Stats");
        XLSX.writeFile(wb, "orderstats.xlsx");
        
    }

    statsNode(stats, td) {
        return _.values(stats).map((o) => (
            td ? <td>{o.kg}</td> : o.kg
        ));
    }

    onSummaryExport() {
        const { orders, orderStatus, isFetching } = this.state;
        if(orders){
            const tHead = [["Mã đơn hàng", "SUPPORTER", "CUSTOMER", "COUNTRY", "Total KG", "SIZE", "TYPE", "HAIR STYLE", "HAIR COLOR", "DRAWN","KG","Note Order","FILE Ảnh","Date Order","Date Ship","Status Order","Reason"]];
            _.values(orders).forEach((order) => {
                let item;
                item = [
                    order.id,  
                    order.id_employee,
                    order.id_customer,
                    order.id_country, 
                    order.kg,       
                    order.id_hair_size, 
                    order.id_hair_type, 
                    order.id_hair_style,
                    order.id_hair_color,
                    order.id_hair_draw,
                    order.kg,
                    order.note,
                    order.img,
                    order.created_at,
                    order.date_ship,
                    order.current_status,
                    order.reason
                ];
                tHead.push(item)
            })
            const wb = XLSX.utils.book_new()
            const wsAll = XLSX.utils.aoa_to_sheet(tHead);
            XLSX.utils.book_append_sheet(wb, wsAll, "Order Summary")
            XLSX.writeFile(wb, "ordersummary.xlsx")

            this.setState({
                isFetching: false,
            })

        }else{
            alert(response.msg)
        }
    }

    onProductExport() {
        const { products, weftTypes} = this.state;
        let tmpWeft = weftTypes.map((type) => type.id);
        const styles = _.filter(this.props.hairStyles,
            (style) => _.includes(tmpWeft, style.id));
        if(products){
            const tHead = [["SIZE"]];
            _.values(styles).forEach((style) => {
                _.head(tHead).push(style.name);
            });
            _.values(products).forEach((product) => {
                       let tmp = [];
                       tmp.push(_.head(_.filter(this.props.hairSizes, (size) => size.id == _.head(product).id_hair_size)).name);

                        styles.forEach((style) => {
                            let target = _.filter(product, (childProduct) => childProduct.id_hair_style == style.id);
                            tmp.push(_.isEmpty(target) ? ' ' : _.head(target).total_kg + 'kg' );
                        });
                    tHead.push(tmp);
            });
            let sum =[];
            sum.push('Tổng');
            styles.map(style => {
                let target = 0;
                {_.values(products).map(product => {
                    target += _.sum(_.values(product).map(p => p.id_hair_style == style.id ? parseFloat(p.total_kg) : 0));
                })}
                sum.push(Math.round(target * 100) / 100 + 'kg');
            });
            tHead.push(sum);

            const wb = XLSX.utils.book_new();
            const wsAll = XLSX.utils.aoa_to_sheet(tHead);
            XLSX.utils.book_append_sheet(wb, wsAll, "Product Summary");
            XLSX.writeFile(wb, "product.xlsx");
        }
    }

    onClosureExport() {
        const {closurePagination, closureFilters, closures, closureTypes} = this.state;
        const types = _.filter(this.props.hairTypes,
            (type) => !_.isEmpty(_.filter(closureTypes, (closure) => closure.id == type.id)));
        if(closures){
            const tHead = [["SIZE"]];
            _.values(types).forEach((style) => {
                _.head(tHead).push(style.name);
            });
            _.values(closures).forEach((product) => {
                       let tmp = [];
                       tmp.push(_.head(_.filter(this.props.hairTypes, (type) => type.id == _.head(product).id_hair_type)).name);
                        types.forEach((type) => {
                            let target = _.filter(product, (childProduct) => childProduct.id_hair_type == type.id);
                            tmp.push(_.isEmpty(target) ? ' ' : _.head(target).total_kg + 'kg' );
                        });
                    tHead.push(tmp);
            });

           let sum =[];
            sum.push('Tổng');
            types.map(type => {
                let target = 0;
                {_.values(closures).map(product => {
                    target += _.sum(_.values(product).map(p => p.id_hair_type == type.id ? parseFloat(p.total_kg) : 0));
                })}
                sum.push(Math.round(target * 100) / 100 + 'kg');
            });
            tHead.push(sum);
            const wb = XLSX.utils.book_new();
            const wsAll = XLSX.utils.aoa_to_sheet(tHead);
            XLSX.utils.book_append_sheet(wb, wsAll, "Closure Summary");
            XLSX.writeFile(wb, "closure-product.xlsx");
        }
    }

    renderStats() {
        const {isFetching, orders, filters, orderStatus} = this.state;
        let statsList;
        let orderStats = orders.stats;
        
        if(!_.isEmpty(orderStats) && !isFetching) {
            statsList = _.values(orderStats).map((o) => (
                <tr>
                    <td>{o.name}</td>
                    {this.statsNode(o.status, true)}
                </tr>
            ));
        }
        else{
            statsList = (
                <div>
                    <h3>There is nothing to statitics</h3>
                </div>
            )
        }

        let statsHead;
        if(!_.isEmpty(orderStatus) && !isFetching) {
            statsHead = orderStatus.map((head) =>
                <th>{head}</th>
            )
        }
        else{
            statsHead = (
                <div>
                    <h3>There is nothing to statitics</h3>
                </div>
            )
        }


        return (
            <div>
                <div className="box-header with-border text-center">
                    <h3 className="">Order Stats</h3>
                </div>
                <div className="filter-report-customer">
                    <div className="filter-report">
                        <div className="filter-from">
                            <span>From:</span>
                            <div className="datePicker">
                                <DatePicker
                                    showYearDropdown
                                    selected={ filters.from ? moment(filters.from) : null}
                                    onChange={this.onChangeDate.bind(this, 'from')}
                                    className="form-control"
                                />
                            </div>
                        </div>
                       <div className="filter-to">
                           <span>To:</span>
                           <div className="datePicker">
                               <DatePicker
                                   showYearDropdown
                                   selected={ filters.to ? moment(filters.to) : null}
                                   onChange={this.onChangeDate.bind(this, 'to')}
                                   className="form-control"
                               />
                           </div>
                       </div>
                       <button className="btn-filter" onClick={this.onRequestFitler.bind(this)}> <i className={'fa fa-filter'}></i></button>
                    </div>
                    <div className="btn-export-excel">
                        <button onClick={this.onExport.bind(this)}>Export</button>
                    </div>
                </div>
                <div className="box table-responsive order-report-container">
                    <table className="table table-hover table-bordered">
                        <thead>
                            <tr>
                                <th>Size</th>
                                {statsHead}
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            {statsList}
                        </tbody>
                    </table>
                </div>
            </div>
        );
    }

    convertLi(arr) {
        return _.values(arr).map((o) => (
            <li>{o}</li>
        ));
    }

    convertUl(arr) {
        if(arr != null) {
            arr = arr.split(',');
        }
        let underList = 
        <ul>
            {this.convertLi(arr)}
        </ul>
        
        return underList;
    }

    calculateTotalKg(arr) {
        if(arr != null) {
            arr = arr.split(',');
        }
        let totalKg = 0;

        _.values(arr).map((o) => (
            totalKg = totalKg + parseInt(o)
        ));

        return totalKg;
    }

    renderOrders() {
        const {isFetching, orders, filters, orderStatus, actions, itemsPerPage , currentPage, totalItems} = this.state;
        let orderList;

        let orderItems = _.remove(_.values(orders),function(n){
            return (_.values(n).length) > 5;
        });

        if(!_.isEmpty(orderItems) && !isFetching) {
            orderList = _.values(orderItems).map((o) => (
                <tr>
                    <td>{o.id}</td>
                    <td>{o.id_employee}</td>
                    <td>{o.id_customer}</td>
                    <td>{o.id_country}</td>
                    <td>{o.kg}</td>
                    <td>{o.id_hair_size}</td>
                    <td>{o.id_hair_type}</td>
                    <td>{o.id_hair_style}</td>
                    <td>{o.id_hair_color}</td>
                    <td>{o.id_hair_color}</td>
                    <td>{o.kg}</td>
                    <td>{o.note ? o.note : '' }</td>
                    <td>{o.img ? <img src={o.img} alt=""/> : null }</td>
                    <td>{o.created_at}</td>
                    <td>{o.date_ship}</td>
                    <td>{o.current_status}</td>
                    <td>{o.reason ? o.reason : '' }</td>
                </tr>
            ));
        }
        else{
            orderList = (
                <div>
                    <h3>There is no order yet.</h3>
                </div>
            )
        }

        return (
            <div>
                <div className="box-header with-border text-center">
                    <h3 className="">Order Summary</h3>
                </div>
                <div className="filter-report-customer">
                    <div className="filter-report">
                        <div className="filter-from">
                            <span>From:</span>
                            <div className="datePicker">
                                <DatePicker
                                    showYearDropdown
                                    selected={ filters.from ? moment(filters.from) : null}
                                    onChange={this.onChangeDate.bind(this, 'from')}
                                    className="form-control"
                                />
                            </div>
                        </div>
                       <div className="filter-to">
                           <span>To:</span>
                           <div className="datePicker">
                               <DatePicker
                                   showYearDropdown
                                   selected={ filters.to ? moment(filters.to) : null}
                                   onChange={this.onChangeDate.bind(this, 'to')}
                                   className="form-control"
                               />
                           </div>
                       </div>
                       <button className="btn-filter" onClick={this.onRequestFitler.bind(this)}> <i className={'fa fa-filter'}></i>Filter</button>
                        <span>              </span>
                       <button className="btn-filter" onClick={this.onRequestFitlerByDateShip.bind(this)}> <i className={'fa fa-filter'}></i>Filter by date ship</button>
                    </div>
                    <div className="btn-export-excel">
                        <button onClick={this.onSummaryExport.bind(this)}>Export</button>
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
                                <td>Mã đơn hàng</td>
                                <td>SUPPORTER</td>
                                <td>CUSTOMER</td>
                                <td>COUNTRY</td>
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

                            {orderList}

                        </tbody>
                    </table>
                </div>
                <div className="box-body">
                    <Pagination
                        activePage={currentPage}
                        itemsCountPerPage={itemsPerPage}
                        totalItemsCount={totalItems}
                        pageRangeDisplayed={5}
                        onChange={this.handlePageChange}
                    />
                </div>
            </div>
        );
    }

    renderProducts() {
        const {productPagination, productFilters, products, weftTypes} = this.state;
        let tmpWeft = weftTypes.map((type) => type.id);
        const styles = _.filter(this.props.hairStyles,
            (style) => _.includes(tmpWeft, style.id));
        return (
            <div>
                <div className="box-header with-border text-center">
                    <h3 className="">Tổng hợp hàng</h3>
                </div>
                <div className="filter-report-customer">
                    <div className="filter-report">
                        <div className="filter-from">
                            <span>From:</span>
                            <div className="datePicker">
                                <DatePicker
                                    showYearDropdown
                                    selected={ productFilters.from ? moment(productFilters.from) : null}
                                    onChange={this.onChangeDate.bind(this, 'from')}
                                    className="form-control"
                                />
                            </div>
                        </div>
                       <div className="filter-to">
                           <span>To:</span>
                           <div className="datePicker">
                               <DatePicker
                                   showYearDropdown
                                   selected={ productFilters.to ? moment(productFilters.to) : null}
                                   onChange={this.onChangeDate.bind(this, 'to')}
                                   className="form-control"
                               />
                           </div>
                       </div>
                       <button className="btn-filter" onClick={this.onRequestProductFitler.bind(this)}> <i className={'fa fa-filter'}></i>Filter</button>
                        <span>              </span>
                    </div>
                    <div className="btn-export-excel">
                        <button onClick={this.onProductExport.bind(this)}>Export</button>
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
                            </tr>
                            {_.values(products).map(product =>
                                    <tr>
                                        <td>
                                                 {_.head(_.filter(this.props.hairSizes, (size) => size.id == _.head(product).id_hair_size)).name}
                                        </td>
                                            {styles.map(style => {
                                                let target = _.filter(product, (childProduct) => childProduct.id_hair_style == style.id);
                                                return (<td>{_.isEmpty(target) ? ' ' : _.head(target).total_kg + 'kg' }</td>)
                                            })}
                                    </tr>
                            )}
                            <tr>
                                <td>Tổng</td>
                                {styles.map(size => {
                                    let target = 0;
                                    {_.values(products).map(product => {
                                        target += _.sum(_.values(product).map(p => p.id_hair_style == size.id ? parseFloat(p.total_kg) : 0));
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

    renderClosures() {
        const {closurePagination, closureFilters, closures, closureTypes} = this.state;
        const types = _.filter(this.props.hairTypes,
            (type) => !_.isEmpty(_.filter(closureTypes, (closure) => closure.id == type.id)));
        return (
            <div>
                <div className="box-header with-border text-center">
                    <h3 className="">BẢNG TỔNG HỢP CLOSURE, FRONTAL</h3>
                </div>
                <div className="filter-report-customer">
                    <div className="filter-report">
                        <div className="filter-from">
                            <span>From:</span>
                            <div className="datePicker">
                                <DatePicker
                                    showYearDropdown
                                    selected={ closureFilters.from ? moment(closureFilters.from) : null}
                                    onChange={this.onChangeDate.bind(this, 'from')}
                                    className="form-control"
                                />
                            </div>
                        </div>
                       <div className="filter-to">
                           <span>To:</span>
                           <div className="datePicker">
                               <DatePicker
                                   showYearDropdown
                                   selected={ closureFilters.to ? moment(closureFilters.to) : null}
                                   onChange={this.onChangeDate.bind(this, 'to')}
                                   className="form-control"
                               />
                           </div>
                       </div>
                       <button className="btn-filter" onClick={this.onRequestClosureFitler.bind(this)}> <i className={'fa fa-filter'}></i>Filter</button>
                        <span>              </span>
                    </div>
                    <div className="btn-export-excel">
                        <button onClick={this.onClosureExport.bind(this)}>Export</button>
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
                            {_.values(closures).map(closure =>
                                    <tr>
                                        <td>
                                                 {_.head(_.filter(this.props.hairTypes, (type) => type.id == _.head(closure).id_hair_type)).name}
                                        </td>
                                            {types.map(type => {
                                                let target = _.filter(closure, (childCclosure) => childCclosure.id_hair_type == type.id);
                                                return (<td>{_.isEmpty(target) ? ' ' : _.head(target).total_kg + 'kg' }</td>)
                                            })}
                                    </tr>
                            )}
                            <tr>
                                <td>Tổng</td>
                                {types.map(size => {
                                    let target = 0;
                                    {_.values(closures).map(product => {
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
        return <div>
            {this.renderStats()}
            {this.renderOrders()}
            {!_.isEmpty(this.state.weftTypes) && this.renderProducts()}
            {!_.isEmpty(this.state.closures) && this.renderClosures()}
        </div>;
    }
}
