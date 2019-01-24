import React, { Component } from 'react';
import Loading from "../layout/loading";
import {requestFilterListCustomer, requestGetListCustomer} from "../../actions/employee";
import * as _ from 'lodash'
import ClassNames from 'classnames'
import Pagination from "react-js-pagination";
import { Link } from 'react-router-dom'
import {hasRole} from "../../utility";
import XLSX from "xlsx";

export default class ListCustomer extends Component {
    constructor(props){
        super(props);
        this.state = {
            isFetching: false,
            customers: this.props.customers,
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
            this.props.dispatch(requestGetListCustomer(this.props.jwt, this.state.id_employee));
    }

    componentWillReceiveProps(nextProps){
        if(nextProps.customers){
            this.setState({
                customers: nextProps.customers,
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
            this.props.dispatch(requestFilterListCustomer({
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
        this.props.dispatch(requestFilterListCustomer({
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

       this.props.dispatch(requestFilterListCustomer({
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
       this.props.dispatch(requestFilterListCustomer({
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
           _.values(this.state.customers).forEach((item) => {
               tHead.push(Object.keys(item).map((key, i) => {
                   if(key == 'is_special_customer') return   item[key] ? 'Active' : 'InActive';
                   return  item[key];

               }))
           });
    

           const wb = XLSX.utils.book_new()
           const wsAll = XLSX.utils.aoa_to_sheet(tHead);
           XLSX.utils.book_append_sheet(wb, wsAll, "All Customer")
           XLSX.writeFile(wb, "customers.xlsx")

       }
    }

    renderList(){
        const {isFetching, customers, actions,itemsPerPage , currentPage, totalItems, filters } = this.state;
            const filterData = (
                <tr>
                    <th scope="col">
                        <input type="search" name='id' value={filters.id.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange} />
                    </th>
                    <th scope="col">
                        <input type="search" name='employee_name' value={filters.employee_name.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/>
                    </th>
                    <th scope="col">
                        <input type="search" name='full_name' value={filters.full_name.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/>
                    </th>
                    <th scope="col">
                        <input type="search" name='phone' value={filters.phone.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/>
                    </th>
                    <th scope="col">
                        <input type="search" name='email' value={filters.email.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/>
                    </th>
                    <th scope="col">
                        <input type="search" name='customer_balance' value={filters.customer_balance.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/>
                    </th>
                    <th scope="col">
                        <select name='status' className='form-control input-sm' defaultValue={filters.status.value} onChange={this.onHandleFilterTextChange}>
                            <option value="null">---</option>
                            <option value="Ordered" >Ordered</option>
                            <option value="Supporting" >Supporting</option>
                            <option value="New" >New</option>
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
            let customerList;
        if(!_.isEmpty(customers) && !isFetching) {
            customerList = customers.map((customer) =>
                <tr key={customer.id}>
                    <td>{customer.id}</td>
                    <td>{customer.employee_name}</td>
                    <td>
                        <Link to={'/customer/detail/'+customer.id} className="btn btn-block btn-sm">
                            {customer.full_name}
                        </Link>
                    </td>
                    <td>{customer.phone}</td>
                    <td>{customer.email}</td>
                    <td>{customer.customer_balance}</td>
                    <td>
                        <button type="button"
                                className={ClassNames("btn btn-block btn-sm ", {'btn-success': customer.status}, {'btn-warning': !customer.status})}> {customer.status}</button>
                    </td>
                    <td colSpan={2}>
                        <Link to={'/customer/edit/'+customer.id} className="btn btn-block btn-sm">
                            <i className={'fa fa-edit'}></i>
                        </Link>
                    </td>
                </tr>
            )
        }
        else{
                 customerList = (
                    <div>
                        <h3>Customer not found</h3>
                    </div>
                )
            }

            return (
                <div className="box box-primary">
                    <div className="box-header with-border text-center">
                        <h3 className="">Customer</h3>
                    </div>
                    <div className="box-body">
                        <div className={ClassNames({'btn-add-custom': true}, {'hidden' : !hasRole('add-customer', actions)})}>
                            {/*<input type="checkbox" value={true} onChange={() => this.setState({ exportWithAll: !this.state.exportWithAll })} /> <span>All customers</span>*/}
                            <button className='btn btn-fat' onClick={this.export}>
                                <i className='fa fa-export'></i> Export
                            </button>
                        </div>
                        <div className={ClassNames({'btn-add-custom': true}, {'hidden' : !hasRole('add-customer', actions)})}>
                            <Link to={'customer/add'} className='btn btn-fat'>
                                <i className='fa fa-plus'></i> Add Customer
                            </Link>
                        </div>
                        <div className="table-responsive">
                            <table className="table table-hover dataTable">
                                <thead>
                                <tr>
                                    <th scope="col" className={ClassNames({'sorting': !filters.id.sort_by },{'th-id':'th-id'}, {'sorting_desc': filters.id.sort_by == 'DESC' },{'sorting_asc': filters.id.sort_by == 'ASC' } )} onClick={this.onHandleSorting.bind(this, 'id' ,filters.id.sort_by)}>ID</th>
                                    <th scope="col" className={ClassNames({'sorting': !filters.employee_name.sort_by},{'th-id':'th-employ'}, {'sorting_desc': filters.employee_name.sort_by == 'DESC' },{'sorting_asc': filters.employee_name.sort_by == 'ASC' }, )} onClick={this.onHandleSorting.bind(this, 'employee_name' ,filters.employee_name.sort_by)}>Employee</th>
                                    <th scope="col" className={ClassNames({'sorting': !filters.full_name.sort_by},{'sorting_desc': filters.full_name.sort_by == 'DESC'},{'sorting_asc': filters.full_name.sort_by == 'ASC' })} onClick={this.onHandleSorting.bind(this, 'full_name' ,filters.full_name.sort_by)}>Full Name</th>
                                    <th scope="col" className={ClassNames({'sorting': !filters.phone.sort_by}, {'sorting_desc': filters.phone.sort_by == 'DESC' },{'sorting_asc': filters.phone.sort_by == 'ASC' })} onClick={this.onHandleSorting.bind(this, 'phone' ,filters.phone.sort_by)}>Phone</th>
                                    <th scope="col" className={ClassNames({'sorting': !filters.email.sort_by}, {'sorting_desc': filters.email.sort_by == 'DESC'},{'sorting_asc': filters.email.sort_by == 'ASC'})} onClick={this.onHandleSorting.bind(this, 'email' ,filters.email.sort_by)}>Email</th>
                                    <th scope="col" className={ClassNames({'sorting': !filters.customer_balance.sort_by },{'th-id':'th-balance'},{'sorting_desc': filters.customer_balance.sort_by == 'DESC'},{'sorting_asc': filters.customer_balance.sort_by == 'ASC'})} onClick={this.onHandleSorting.bind(this,'customer_balance' ,filters.customer_balance.sort_by)}>Balance</th>
                                    <th scope="col" className={ClassNames({'sorting': !filters.status.sort_by },{'sorting_desc': filters.status.sort_by == 'DESC'},{'sorting_asc': filters.status.sort_by == 'ASC'})} onClick={this.onHandleSorting.bind(this, 'status' , filters.status.sort_by)}>Status</th>
                                    <th scope="col">Action</th>
                                </tr>
                                {filterData}
                                </thead>
                                <tbody>
                                  {customerList}
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
