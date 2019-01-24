import React, { Component } from 'react';
import Loading from "./layout/loading";
import {requestFilter, requestGetList} from "../actions/history";
import * as _ from 'lodash'
import ClassNames from 'classnames'
import Pagination from "react-js-pagination";
import { Link } from 'react-router-dom'
import Api from '../api'
import DatePicker from "react-datepicker";
import moment from "frozen-moment";
import "react-datepicker/dist/react-datepicker.css";

export default class History extends Component{
    constructor(props){
        super(props);
        const date = moment();
        this.state = {
            isFetching: false,
            histories: this.props.histories,
            pageLimit: this.props.pageLimit,
            currentPage: this.props.currentPage,
            jwt: this.props.jwt,
            totalItems: this.props.totalItems,
            itemsPerPage: this.props.itemsPerPage,
            filters: this.props.filters,
            actions: this.props.actions
        };
        this.handlePageChange = this.handlePageChange.bind(this)
        this.onHandleSorting = this.onHandleSorting.bind(this)
    }


    componentWillMount(){
        if(_.isEmpty(this.state.histories)){
            this.setState({
                isFetching: true
            });
            this.props.dispatch(requestGetList(this.props.jwt));
        }
    }

    componentWillReceiveProps(nextProps){
        if(nextProps.histories){
            this.setState({
                histories: nextProps.histories,
                currentPage: nextProps.currentPage,
                pageLimit: nextProps.pageLimit,
                itemsPerPage: nextProps.itemsPerPage,
                totalItems: nextProps.totalItems,
                filters: nextProps.filters,
                isFetching: false
            });
        }
    }

    handlePageChange(pageNumber){
        if(pageNumber){
            this.setState({
                isFetching: true
            });
            this.props.dispatch(requestFilter({
                jwt: this.state.jwt,
                page: pageNumber,
                filters: this.state.filters
            }));
        }
    }

    onHandleSorting(field, sortBy){
        const filters = this.props.filters;
        _.each(filters, (f,k) => {
            if(k != field && k!='from' && k != 'to'){
                f.sort_by = '';
            }
        });
        filters[field].sort_by = sortBy == 'DESC' ? 'ASC' : 'DESC';
        this.setState({
            filters: filters,
        });
        this.props.dispatch(requestFilter({
            jwt: this.state.jwt,
            page: this.state.currentPage,
            filters: filters
        }))
    }

    onChangeDate(field, date) {
        this.setState({
            filters: Object.assign({}, this.state.filters, {
                [field] : date.format('YYYY-MM-DD 23:59:59')
            })
        });
    }

    onRequestFitler(){
        this.setState({
            isFetching: true
        });
        this.props.dispatch(requestFilter({
            jwt: this.state.jwt,
            page: this.state.currentPage,
            filters: this.state.filters
        }));
    }

    renderList(){
        const {isFetching, histories, actions,itemsPerPage , currentPage, totalItems, filters } = this.state;
            let historyList;
        if(!_.isEmpty(histories) && !isFetching) {
            historyList = histories.map((history) =>
                <tr key={history.id}>
                    <td>{history.id}</td>
                    {/* <td>{history.id_item}</td> */}
                    <td>{history.employee_name}</td>
                    <td>{history.model}</td>
                    <td>{history.action}</td>
                    <td>{history.created_at}</td>
                </tr>
            )
        }
        else{
            historyList = (
                    <div>
                        <h3>History is empty</h3>
                    </div>
                )
            }

            return (
                <div className="box box-primary">
                    <div className="box-header with-border text-center">
                        <h3 className="">History</h3>
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
                    </div>
                    <div className="box-body list-product-report">
                        <div className="table-responsive">
                            <table className="table table-hover dataTable">
                                <thead>
                                <tr>
                                    <th scope="col" className={ClassNames({'sorting': !filters.id.sort_by },{'th-id':'th-id'}, {'sorting_desc': filters.id.sort_by == 'DESC' },{'sorting_asc': filters.id.sort_by == 'ASC' } )} onClick={this.onHandleSorting.bind(this, 'id' ,filters.id.sort_by)}>ID</th>
                                    {/* <th scope="col" className={ClassNames({'sorting': !filters.id_item.sort_by},{'th-id':'th-employ'}, {'sorting_desc': filters.id_item.sort_by == 'DESC' },{'sorting_asc': filters.id_item.sort_by == 'ASC' }, )} onClick={this.onHandleSorting.bind(this, 'id_item' ,filters.id_item.sort_by)}>ID Item</th> */}
                                    <th scope="col" className={ClassNames({'sorting': !filters.employee_name.sort_by},{'th-id':'th-employ'}, {'sorting_desc': filters.employee_name.sort_by == 'DESC' },{'sorting_asc': filters.employee_name.sort_by == 'ASC' }, )} onClick={this.onHandleSorting.bind(this, 'employee_name' ,filters.employee_name.sort_by)}>Employee</th>
                                    <th scope="col" className={ClassNames({'sorting': !filters.model.sort_by},{'sorting_desc': filters.model.sort_by == 'DESC'},{'sorting_asc': filters.model.sort_by == 'ASC' })} onClick={this.onHandleSorting.bind(this, 'model' ,filters.model.sort_by)}>Content</th>
                                    <th scope="col" className={ClassNames({'sorting': !filters.action.sort_by}, {'sorting_desc': filters.action.sort_by == 'DESC' },{'sorting_asc': filters.action.sort_by == 'ASC' })} onClick={this.onHandleSorting.bind(this, 'action' ,filters.action.sort_by)}>Action</th>
                                    <th scope="col" className={ClassNames({'sorting': !filters.created_at.sort_by}, {'sorting_desc': filters.created_at.sort_by == 'DESC' },{'sorting_asc': filters.created_at.sort_by == 'ASC' })} onClick={this.onHandleSorting.bind(this, 'created_at' ,filters.created_at.sort_by)}>Created at</th>
                                </tr>
                                </thead>
                                <tbody>
                                  {historyList}
                                </tbody>
                            </table>
                        </div>
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

    render(){
        const { histories, isFetching } = this.state;
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
