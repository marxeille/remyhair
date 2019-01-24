import React, { Component } from 'react'
import {requestFilter, requestGetList} from "../../actions/support";
import * as _ from "lodash";
import Pagination from "react-js-pagination";
import Loading from "../layout/loading";
import ClassNames from 'classnames'
import {replaceAll} from "../../utility";
import XLSX from "xlsx";
import { Link } from 'react-router-dom'
import moment from 'moment';
import FilterFromTo from '../helper/filterFromTo'

export default class Support extends Component{
    constructor(props){
        super(props);
        this.state = {
            isFetching: true,
            supports: this.props.supports,
            support: this.props.support,
            pageLimit: this.props.pageLimit,
            currentPage: this.props.currentPage,
            jwt: this.props.jwt,
            totalItems: 0,
            itemsPerPage: 0,
            filters: this.props.filters,
        };
        this.renderList = this.renderList.bind(this);
        this.handlePageChange = this.handlePageChange.bind(this);
        this.onHandleSorting = this.onHandleSorting.bind(this);
        this.onHandleFilterTextChange = this.onHandleFilterTextChange.bind(this);
        this.onRequestFitler = this.onRequestFitler.bind(this);
        this.onRequestResetFitler = this.onRequestResetFitler.bind(this);
        this.onChangeDate = this.onChangeDate.bind(this);
        this.export = this.export.bind(this);
    }

    componentDidMount(){
        this.props.dispatch(requestGetList(this.props.jwt));
    }

    componentWillMount(){
        this.setState({
            isFetching: true
        });
    }

    componentWillReceiveProps(nextProps){
        if(nextProps.supports){
            this.setState({
                supports: nextProps.supports,
                currentPage: nextProps.currentPage,
                pageLimit: nextProps.pageLimit,
                itemsPerPage: nextProps.itemsPerPage,
                totalItems: nextProps.totalItems,
                filters: nextProps.filters,
                isFetching: nextProps.isFetching,
                invoiceStatus: nextProps.invoiceStatus,
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

    onHandleFilterTextChange(event){
        const filters = this.state.filters;
        filters[event.target.name].value = event.target.value!='null' ? event.target.value : '';
        this.setState({
            filters: filters
        });
    }

    onHandleSorting(field, sortBy){
        const filters = this.props.filters;
        _.each(filters, (f,k) => {
            if(k != field && k != 'from' && k != 'to'){
                f.sort_by = '';
            }
        });
        filters[field].sort_by = sortBy == 'DESC' ? 'ASC' : 'DESC';
        this.setState({
            filters: filters,
        });
        this.props.dispatch(requestFilter({
            jwt: this.props.jwt,
            page: this.state.currentPage,
            filters: filters
        }))
    }

    onRequestResetFitler(){
        const filters = this.props.filters;
        _.each(filters, (f,k) => {
            if( k!= 'from' && k!='to'){
                f.sort_by = null;
                f.value = ""
            }
        });

        this.setState({
            isFetching: true,
            filters: filters
        });

        this.props.dispatch(requestFilter({
            jwt: this.props.jwt,
            page: this.state.currentPage,
            filters: filters



        }));
    }

    onChangeDate(field, date) {
        this.setState({
            filters: Object.assign({}, this.state.filters, {
                [field]: date.format('YYYY-MM-DD 23:59:59')
            })
        });
    }

    export() {
        const { supports } = this.state;
        const tHead = [["ID", "Employee", "Customer", "Invoice status", "Support time", "Updated at", "Customer type", "Complain", "Note"]];
        _.values(supports).forEach(support => {
            // let notes = replaceAll(support.note, ',', '&CHAR(10)&');
            tHead.push([support.id, support.employee_name, support.customer_name,support.invoice_status, parseInt(moment(moment(new Date()).format('YYYY-MM-DD')).diff(moment(support.updated_at), 'day')) + 1, support.updated_at, support.customer_type, support.complain ? support.complain : '', support.note])
        });

        const wb = XLSX.utils.book_new();
        const wsAll = XLSX.utils.aoa_to_sheet(tHead);
        XLSX.utils.book_append_sheet(wb, wsAll, "Support");
        XLSX.writeFile(wb, "support.xlsx");
    }

    onRequestFitler(){
        this.setState({
            isFetching: true
        });

        this.props.dispatch(requestFilter({
            jwt: this.props.jwt,
            page: this.state.currentPage,
            filters: this.state.filters
        }));
    }
    renderList(){
        const {isFetching, supports, itemsPerPage , currentPage, totalItems, statuss, filters, invoiceStatus } = this.state;
        const filterData = (
            <tr>
                <th scope="col">
                    <input type="search" name='id' value={filters.id.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange} />
                </th>
                <th scope="col">
                    <input type="search" name='employee_name' value={filters.employee_name.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/>
                </th>
                <th scope="col">
                    <input type="search" name='customer_name' value={filters.customer_name.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/>
                </th>
                <th scope="col">
                    <select name='invoice_status' className='form-control input-sm' onChange={this.onHandleFilterTextChange} defaultValue={filters.invoice_status.value}>
                        <option value="null">Options</option>
                        {invoiceStatus.map((status, key)=>(
                            <option key={key} value={status.name}>{status.name}</option>
                        ))}
                    </select>
                </th>
                <th scope="col">
                    <input type="search" name='support_time' value={filters.support_time.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/>
                </th>
                <th scope="col">
                    <select name="customer_type"  className={'form-control'} onChange={this.onHandleFilterTextChange} defaultValue={filters.customer_type.value}>
                        <option value="null">Options</option>
                        {this.props.customer_types.map((type, i)=>(
                            <option key={i} value={type} >{type}</option>
                        ))}
                    </select>
                </th>
                <th scope="col">
                    <button className="btn btn-flat btn-default" onClick={this.onRequestResetFitler}>
                        <i className={'fa fa-refresh'}></i>
                    </button>
                </th>
                <th scope="col">
                    <button className="btn btn-flat btn-info" onClick={this.onRequestFitler}>
                        <i className={'fa fa-filter'}></i>
                    </button>
                </th>
            </tr>
        );
        let supportList;
        if(!_.isEmpty(supports) && !isFetching) {
            supportList = supports.map((support) =>
                <tr key={support.id}>
                    <td>{support.id}</td>
                    <td>
                        <Link to={'/support/detail/'+support.id} className="btn btn-block btn-sm">
                            {support.employee_name}
                        </Link>
                    </td>
                    <td>{support.customer_name}</td>
                    <td >{support.invoice_status}</td>
                    <td className={ClassNames({'td-success': support.status == 'Open' && moment(moment(new Date()).format('YYYY-MM-DD')).diff(moment(support.updated_at), 'day') < 3 ? true : false, 'td-warning' : support.status == 'Open' && moment(moment(new Date()).format('YYYY-MM-DD')).diff(moment(support.updated_at), 'day') >= 3 && moment(moment(new Date()).format('YYYY-MM-DD')).diff(moment(support.updated_at), 'day') <= 5 ? true : false , 'td-danger': support.status == 'Open' && moment(moment(new Date()).format('YYYY-MM-DD')).diff(moment(support.updated_at), 'day') > 5  ? true : false},'text-center')}><span>{parseInt(moment(moment(new Date()).format('YYYY-MM-DD')).diff(moment(support.updated_at), 'day')) + 1}</span></td>
                    <td className="text-center">{support.customer_type}</td>
                    <td className="text-center">{support.updated_at}</td>
                    <td colSpan={2}>
                        <Link to={'/support/edit/'+support.id} className="btn btn-block btn-sm">
                            <i className={'fa fa-edit'}></i>
                        </Link>
                    </td>
                </tr>
            )
        }
        else{
            supportList = (
                <div>
                    <h3>Support not found</h3>
                </div>
            )
        }

        return (
            <div className="box box-primary">
                <div className="box-header with-border text-center">
                    <h1 className="box-title">Support</h1>
                </div>
                <div className="filter-report">
                    <FilterFromTo filter={filters} onChangeDate={this.onChangeDate}/>
                    <button className="btn-filter" onClick={this.onRequestFitler.bind(this)}> <i className={'fa fa-filter'}></i></button>
                    
                </div>
                <div className="btn-export-excel">
                    <button onClick={this.export}>Export</button>
                </div>
                <div className="box-body">
                    <div className="btn-add-custom">
                        <Link to={'support/add'} className='btn btn-fat'>
                            <i className='fa fa-plus'></i> Add Support
                        </Link>
                    </div>
                    <div className="table-responsive clear-fix">
                        <table className="table table-hover dataTable radius-custom-table">
                            <thead>
                            <tr>
                                <th width="50" scope="col" className={ClassNames({'sorting': !filters.id.sort_by }, {'sorting_desc': filters.id.sort_by == 'DESC' },{'sorting_asc': filters.id.sort_by == 'ASC' }, )} onClick={this.onHandleSorting.bind(this, 'id' ,filters.id.sort_by)}>ID</th>
                                <th scope="col" className={ClassNames({'sorting': !filters.employee_name.sort_by}, {'sorting_desc': filters.employee_name.sort_by == 'DESC' },{'sorting_asc': filters.employee_name.sort_by == 'ASC' }, )} onClick={this.onHandleSorting.bind(this, 'employee_name' ,filters.employee_name.sort_by)}>Employee</th>
                                <th scope="col" className={ClassNames({'sorting': !filters.customer_name.sort_by},{'sorting_desc': filters.customer_name.sort_by == 'DESC'},{'sorting_asc': filters.customer_name.sort_by == 'ASC' })} onClick={this.onHandleSorting.bind(this, 'customer_name' ,filters.customer_name.sort_by)}>Customer</th>
                                <th scope="col" className={ClassNames({'sorting': !filters.invoice_status.sort_by}, {'sorting_desc': filters.invoice_status.sort_by == 'DESC' },{'sorting_asc': filters.invoice_status.sort_by == 'ASC' })} onClick={this.onHandleSorting.bind(this, 'invoice_status' ,filters.invoice_status.sort_by)}>Invoice status</th>
                                <th width="100" scope="col" className={ClassNames({'sorting': !filters.support_time.sort_by}, {'sorting_desc': filters.support_time.sort_by == 'DESC'},{'sorting_asc': filters.support_time.sort_by == 'ASC'})} onClick={this.onHandleSorting.bind(this, 'support_time' ,filters.support_time.sort_by)}>Support time</th>
                                <th scope="col" className={ClassNames({'sorting': !filters.updated_at.sort_by}, {'sorting_desc': filters.updated_at.sort_by == 'DESC'},{'sorting_asc': filters.updated_at.sort_by == 'ASC'})} onClick={this.onHandleSorting.bind(this, 'updated_at' ,filters.updated_at.sort_by)}>Customer type</th>
                                <th scope="col" className={ClassNames({'sorting': !filters.status.sort_by},{'sorting_desc': filters.status.sort_by == 'DESC'},{'sorting_asc': filters.status.sort_by == 'ASC'})} onClick={this.onHandleSorting.bind(this, 'status' ,filters.status.sort_by)}>Updated at</th>
                                <th scope="col">Action</th>
                            </tr>
                            {filterData}
                            </thead>
                            <tbody>
                            {supportList}
                            </tbody>
                        </table>
                    </div></div>
                <Pagination
                    activePage={currentPage}
                    itemsCountPerPage={itemsPerPage}
                    totalItemsCount={totalItems}
                    pageRangeDisplayed={5}
                    onChange={this.handlePageChange}
                />
            </div>
        );
    }

    onAdd(){
        this.setState((prevState) => ({
            clicks: prevState.clicks + 1
        }));
    }

    render(){
        const {isFetching } = this.state;
        if(isFetching){
            return <Loading/>
        }
        return(
            <div className="row">
                {this.renderList()}
            </div>
        )
    }
}
