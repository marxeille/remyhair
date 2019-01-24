import React, { Component } from 'react';
import Loading from "../layout/loading";
import {
    requestFilterListCustomer,
    requestFilterListSupport,
    requestGetListCustomer,
    requestGetListSupport
} from "../../actions/employee";
import * as _ from 'lodash'
import ClassNames from 'classnames'
import Pagination from "react-js-pagination";
import { Link } from 'react-router-dom'
import {hasRole} from "../../utility";
import XLSX from "xlsx";
import moment from "moment";

export default class ListSupport extends Component {
    constructor(props){
        super(props);
        this.state = {
            isFetching: false,
            supports: this.props.supports,
            pageLimit: this.props.pageLimit,
            currentPage: this.props.currentPage,
            jwt: this.props.jwt,
            totalItems: this.props.totalItems,
            itemsPerPage: this.props.itemsPerPage,
            filters: this.props.filters,
            actions: this.props.actions,
            id_employee: this.props.match.params.id,
            exportWithAll: false,
        };
        this.onHandleFilterTextChange = this.onHandleFilterTextChange.bind(this);
        this.handlePageChange = this.handlePageChange.bind(this);
        this.onHandleSorting = this.onHandleSorting.bind(this);
        this.onRequestResetFitler = this.onRequestResetFitler.bind(this);
        this.onRequestFitler = this.onRequestFitler.bind(this);
        this.export = this.export.bind(this);
    }

    componentWillMount(){
            this.setState({
                isFetching: true
            });
            this.props.dispatch(requestGetListSupport(this.props.jwt, this.state.id_employee));
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
                isFetching: false,
                invoiceStatus: nextProps.invoiceStatus,
            });
        }
    }

    handlePageChange(pageNumber){
        if(pageNumber){
            this.setState({
                isFetching: true
            });
            this.props.dispatch(requestFilterListSupport({
                jwt: this.state.jwt,
                id_employee: this.props.match.params.id,
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
          if(k != field && k !='from' && k != 'to'){
              f.sort_by = '';
          }
        });
        filters[field].sort_by = sortBy == 'DESC' ? 'ASC' : 'DESC';
        this.setState({
            filters: filters,
        });
        this.props.dispatch(requestFilterListSupport({
            jwt: this.state.jwt,
            id_employee: this.props.match.params.id,
            page: this.state.currentPage,
            filters: filters
        }))
    }

    onRequestResetFitler(){
        const filters = this.props.filters;
        _.each(filters, (f,k) => {
            if( k != 'from' && k != 'to'){
                f.sort_by = null;
                f.value = ""
            }

        });

       this.setState({
           isFetching: true,
           filters: filters
       });

       this.props.dispatch(requestFilterListSupport({
           jwt: this.state.jwt,
           id_employee: this.props.match.params.id,
           page: 1,
           filters: filters
       }));
    }

    onRequestFitler(){
       this.setState({
           isFetching: true
       });
       this.props.dispatch(requestFilterListSupport({
           jwt: this.state.jwt,
           id_employee: this.props.match.params.id,
           page: this.state.currentPage,
           filters: this.state.filters
       }));
    }

    export(){
       if(this.state.exportWithAll){

       }else{
           const tHead = [["ID", "ID employee", "Employee", "Full name", "Phone", "Email", "Balance", "Special customer", "Status", "Type"]];
           _.values(this.state.supports).forEach((item) => {
               tHead.push(Object.keys(item).map((key, i) => {
                   if(key == 'is_special_customer') return   item[key] ? 'Active' : 'InActive';
                   return  item[key];

               }))
           });

           const wb = XLSX.utils.book_new()
           const wsAll = XLSX.utils.aoa_to_sheet(tHead);
           XLSX.utils.book_append_sheet(wb, wsAll, "All Support")
           XLSX.writeFile(wb, "support.xlsx")

       }
    }

    renderList(){
        const {isFetching, supports, actions,itemsPerPage , currentPage, totalItems, filters, invoiceStatus } = this.state;
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
                        <select name='invoice_status' className='form-control input-sm' onChange={this.onHandleFilterTextChange}>
                            <option value="null">Options</option>
                            {invoiceStatus.map((status)=>(
                                <option selected={filters.invoice_status.value == status.name} value={status.name}>{status.name}</option>
                            ))}
                        </select>
                    </th>
                    <th scope="col">
                        <input type="search" name='support_time' value={filters.support_time.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/>
                    </th>
                    <th scope="col">
                        <select name="status"  className={'form-control'} defaultValue={filters.status.value} onChange={this.onHandleFilterTextChange}>
                            <option value="null">Options</option>
                            {this.props.support_status.map((status, i)=>(
                                <option value={status} >{status}</option>
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
                    <td className={ClassNames({'label-success': support.status == 'Open' && moment(moment(new Date()).format('YYYY-MM-DD')).diff(moment(support.updated_at), 'day') < 3 ? true : false, 'label-warning' : support.status == 'Open' && moment(moment(new Date()).format('YYYY-MM-DD')).diff(moment(support.updated_at), 'day') >= 3 && moment(moment(new Date()).format('YYYY-MM-DD')).diff(moment(support.updated_at), 'day') <= 5 ? true : false , 'label-danger': support.status == 'Open' && moment(moment(new Date()).format('YYYY-MM-DD')).diff(moment(support.updated_at), 'day') > 5  ? true : false})}>{moment(moment(new Date()).format('YYYY-MM-DD')).diff(moment(support.updated_at), 'day')}</td>
                    <td className="text-center">{support.status}</td>
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
                        <h3 className="">Support</h3>
                    </div>
                    <div className="box-body">
                        <div className={ClassNames({'btn-add-custom': true}, {'hidden' : !hasRole('add-customer', actions)})}>
                            {/*<input type="checkbox" value={true} onChange={() => this.setState({ exportWithAll: !this.state.exportWithAll })} /> <span>All customers</span>*/}
                            <button className='btn btn-fat' onClick={this.export}>
                                <i className='fa fa-export'></i> Export
                            </button>
                        </div>
                        <div className="table-responsive">
                            <table className="table table-hover dataTable">
                                <thead>
                                <tr>
                                    <th scope="col" className={ClassNames({'sorting': !filters.id.sort_by }, {'sorting_desc': filters.id.sort_by == 'DESC' },{'sorting_asc': filters.id.sort_by == 'ASC' }, )} onClick={this.onHandleSorting.bind(this, 'id' ,filters.id.sort_by)}>ID</th>
                                    <th scope="col" className={ClassNames({'sorting': !filters.employee_name.sort_by}, {'sorting_desc': filters.employee_name.sort_by == 'DESC' },{'sorting_asc': filters.employee_name.sort_by == 'ASC' }, )} onClick={this.onHandleSorting.bind(this, 'employee_name' ,filters.employee_name.sort_by)}>Employee</th>
                                    <th scope="col" className={ClassNames({'sorting': !filters.customer_name.sort_by},{'sorting_desc': filters.customer_name.sort_by == 'DESC'},{'sorting_asc': filters.customer_name.sort_by == 'ASC' })} onClick={this.onHandleSorting.bind(this, 'customer_name' ,filters.customer_name.sort_by)}>Customer</th>
                                    <th scope="col" className={ClassNames({'sorting': !filters.invoice_status.sort_by}, {'sorting_desc': filters.invoice_status.sort_by == 'DESC' },{'sorting_asc': filters.invoice_status.sort_by == 'ASC' })} onClick={this.onHandleSorting.bind(this, 'invoice_status' ,filters.invoice_status.sort_by)}>Invoice status</th>
                                    <th scope="col" className={ClassNames({'sorting': !filters.support_time.sort_by}, {'sorting_desc': filters.support_time.sort_by == 'DESC'},{'sorting_asc': filters.support_time.sort_by == 'ASC'})} onClick={this.onHandleSorting.bind(this, 'support_time' ,filters.support_time.sort_by)}>Support time</th>
                                    <th scope="col" className={ClassNames({'sorting': !filters.status.sort_by},{'sorting_desc': filters.status.sort_by == 'DESC'},{'sorting_asc': filters.status.sort_by == 'ASC'})} onClick={this.onHandleSorting.bind(this, 'status' ,filters.status.sort_by)}>Status</th>
                                    <th scope="col">Action</th>
                                </tr>
                                {filterData}
                                </thead>
                                <tbody>
                                  {supportList}
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
                    <div className="box-footer">
                        <button type="button" onClick={() => this.props.history.push('/employee/detail/' + this.state.id_employee)} className="btn btn-default">Back</button>
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
