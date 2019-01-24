import React, { Component } from 'react';
import Loading from "../layout/loading";
import {requestFilter, requestGetList} from "../../actions/saleCommission";
import * as _ from 'lodash'
import ClassNames from 'classnames'
import { Link } from 'react-router-dom'
import DatePicker from "react-datepicker/es";
import moment from "frozen-moment";
import XLSX from "xlsx";

export default class SaleCommission extends Component {
    constructor(props){
        super(props);
        this.state = {
            isFetching: false,
            saleCommissions: this.props.saleCommissions,
            saleCommission: this.props.saleCommission,
            jwt: this.props.jwt,
            filters: this.props.filters,
            actions: this.props.actions
        };
        this.onRequestFilter = this.onRequestFilter.bind(this);
        this.onChangeDate = this.onChangeDate.bind(this);
        this.onRequestFilterByDateShip = this.onRequestFilterByDateShip.bind(this);
        this.export = this.export.bind(this);
    }

    componentWillMount(){
        if(_.isEmpty(this.state.customers)){
            this.setState({
                isFetching: true
            });
            this.props.dispatch(requestGetList(this.props.jwt, this.state.filters));
        }
    }

    componentWillReceiveProps(nextProps){
            this.setState({
                isFetching: false,
                saleCommissions: nextProps.saleCommissions,
                filters: nextProps.filters,
            });
    }
    onRequestFilter(){
       this.setState({
           isFetching: true
       });
       this.props.dispatch(requestGetList(this.props.jwt, this.state.filters));
    }

    onChangeDate(field, date) {
        this.setState({
            filters: Object.assign({}, this.state.filters, {
                [field]: date.format('YYYY-MM-DD 23:59:59')
            })
        });
    }

    onRequestFilterByDateShip() {
        this.setState({
            isFetching: true
        });
        this.props.dispatch(requestGetList(this.props.jwt, this.state.filters));
    }

    export() {
        const {saleCommissions} = this.state;
        if(saleCommissions){
            const tHead = [["Supporter", "Total KG", "Sale commission"]];
            _.values(saleCommissions).forEach((sale) => {
                let tmp = [];
                tHead.push([sale.employee.name, sale.total_kg, sale.sale_commission]);
            });

            const wb = XLSX.utils.book_new();
            const wsAll = XLSX.utils.aoa_to_sheet(tHead);
            XLSX.utils.book_append_sheet(wb, wsAll, "Sale commission");
            XLSX.writeFile(wb, "sale-commission.xlsx");
        }
    }

    renderList(){
        const {isFetching, saleCommissions, filters } = this.state;
        let saleCommissionList;
        if(!_.isEmpty(saleCommissions) && !isFetching) {
            saleCommissionList = saleCommissions.map((saleCommission) =>
                <tr key={saleCommission.id}>
                    <td>
                        <Link to={'/report/sale-commission/'+saleCommission.employee.id} className="btn btn-block btn-sm">
                            {saleCommission.employee.name}
                        </Link>
                    </td>
                    <td>{saleCommission.total_kg}</td>
                    <td>{saleCommission.sale_commission}</td>
                </tr>
            )
        }
        else{
            saleCommissionList = (
                    <div>
                        <h3>No sale commission not found</h3>
                    </div>
                )
            }

            return (
                <div>
                    <div className="box-header with-border text-center">
                        <h3 className="">Sale commission</h3>
                    </div>
                    <div className="box-body">
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
                            <button className="btn-filter" onClick={this.onRequestFilter.bind(this)}> <i className={'fa fa-filter'}></i>Filter</button>
                            <span>              </span>
                            <button className="btn-filter" onClick={this.onRequestFilterByDateShip}> <i className={'fa fa-filter'}></i>Filter by date ship</button>
                        </div>
                        <div className="btn-export-excel">
                            <button onClick={this.export}>Export</button>
                        </div>
                        <div className="box table-responsive">
                            <table className="table table-hover dataTable">
                                <thead>
                                <tr>
                                    <th scope="col" className={ClassNames({'th-id':'th-employ'})} >Supporter </th>
                                    <th scope="col" className={ClassNames({'th-id':'th-employ'})} >Total KG </th>
                                    <th scope="col" className={ClassNames({'th-id':'th-employ'})} >Sale commission </th>
                                </tr>
                                </thead>
                                <tbody>
                                  {saleCommissionList}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            );
    }

	render() {
        const { isFetching } = this.state;
        if(isFetching){
            return <Loading/>
        }
		return (
			<div>
                {this.renderList()}
			</div>
		);
	}
}
