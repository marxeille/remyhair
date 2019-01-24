import React, { Component } from 'react';
import Loading from "../layout/loading";
import {requestDeleteCustomer, requestFilter, requestGetList} from "../../actions/customer";
import * as _ from 'lodash'
import ClassNames from 'classnames'
import Pagination from "react-js-pagination";
import { Link } from 'react-router-dom'
import {hasRole} from "../../utility";
import ImportCustomer from './importCustomer';
import FilterFromTo from "../helper/filterFromTo";

export default class Customer extends Component {
    constructor(props){
        super(props);
        this.state = {
            isFetching: false,
            customers: this.props.customers,
            initData: this.props.initData,
            customer: this.props.customer,
            pageLimit: this.props.pageLimit,
            currentPage: this.props.currentPage,
            jwt: this.props.jwt,
            totalItems: this.props.totalItems,
            itemsPerPage: this.props.itemsPerPage,
            filters: this.props.filters,
            actions: this.props.actions
        };
        this.onHandleFilterTextChange = this.onHandleFilterTextChange.bind(this);
        this.handlePageChange = this.handlePageChange.bind(this);
        this.onHandleSorting = this.onHandleSorting.bind(this);
        this.onRequestResetFitler = this.onRequestResetFitler.bind(this);
        this.onRequestFitler = this.onRequestFitler.bind(this);
        this.onChangeDate = this.onChangeDate.bind(this);
    }

    componentWillMount(){
        if(_.isEmpty(this.state.customers)){
            this.setState({
                isFetching: true
            });
            this.props.dispatch(requestGetList(this.props.jwt));
        }
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
            jwt: this.state.jwt,
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
           jwt: this.state.jwt,
           page: 1,
           filters: filters
       }));
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

    onChangeDate(field, date) {
        this.setState({
            filters: Object.assign({}, this.state.filters, {
                [field]: date.format('YYYY-MM-DD 23:59:59')
            })
        });
    }

    delete(id) {
        if(hasRole('delete-customer', this.props.actions)){
            this.props.dispatch(requestDeleteCustomer(this.state.jwt, id));
        }else{
            alert('You have no permission');
        }
    }
    renderList(){
        const {isFetching, customers, actions,itemsPerPage , currentPage, totalItems, filters, initData } = this.state;
            const filterData = (
                <tr>
                    
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
                        <select name='is_special_customer' className='form-control input-sm' onChange={this.onHandleFilterTextChange}>
                            <option value="null">---</option>
                            <option value="1" defaultChecked={filters.is_special_customer.value == true && filters.is_special_customer.value !=''} >Special</option>
                            <option value="0" defaultChecked={filters.is_special_customer.value == false && filters.is_special_customer.value !=''}>None special</option>
                        </select>
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
                    <td>
                        <Link to={'/customer/detail/'+customer.id} className="btn btn-block btn-sm">
                            {customer.full_name}
                        </Link>
                    </td>
                    <td>{customer.phone}</td>
                    <td>{customer.email}</td>
                    <td>{customer.customer_balance}</td>
                    <td>{customer.is_special_customer ? <span className="label label-success">Special</span> : ''}</td>
                    <td>
                        {
                            customer.status == 'New'
                            ?
                                <button 
                                    type="button"
                                    className={ClassNames("btn btn-block btn-sm ", customer.status.toLowerCase())}
                                > 
                                    <Link to={'/add/support/'+customer.id} className="btn btn-block btn-sm">
                                        <span className="link-support">{customer.status}</span>
                                    </Link>
                                </button>
                            :
                                <button 
                                    type="button"
                                    className={ClassNames("btn btn-block btn-sm ", customer.status.toLowerCase())}
                                > 
                                    {customer.status}
                                </button>
                        }
                    </td>
                    <td >
                        <Link to={'/customer/edit/'+customer.id} className="btn btn-block btn-sm">
                            <i className={'fa fa-edit'}></i>
                        </Link>
                    </td>
                    <td>
                        <a 
                            href={'javascrip::void(0)'}
                            onClick={() => {
                                if(confirm('Are you sure?')){
                                    this.delete(customer.id)
                                }
                            }}
                            className="btn btn-block btn-sm">
                            <i className={'fa fa-remove'}></i>
                        </a>
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
                    <div className="filter-report">
                        <FilterFromTo filter={filters} onChangeDate={this.onChangeDate}/>
                        <button className="btn-filter" onClick={this.onRequestFitler.bind(this)}> <i className={'fa fa-filter'}></i></button>
                    </div>
                    <div className="clearfix"></div>
                    <div className="box-body">
                        <div className="menu">
                            <div className="btn-add-custom btn-import">
                                <ImportCustomer jwt={this.props.jwt} dispatch={this.props.dispatch} initData={initData} />
                            </div>
                            <div className={ClassNames({'btn-add-custom': true}, {'hidden' : !hasRole('add-customer', actions)})}>
                                <Link to={'customer/add'} className='btn btn-fat'>
                                    <i className='fa fa-plus'></i> Add Customer
                                </Link>
                                <Link to={'unsupport'} className='btn btn-fat'>
                                    <i className='fa fa-list'></i> Unsupport list
                                </Link>
                            </div>
                        </div>
                        <div className="clearfix"></div>

                        <div className="table-responsive table-customer-list">
                            <table className="table table-hover dataTable">
                                <thead>
                                <tr>
                                    <th scope="col" className={ClassNames({'sorting': !filters.full_name.sort_by},{'sorting_desc': filters.full_name.sort_by == 'DESC'},{'sorting_asc': filters.full_name.sort_by == 'ASC' })} onClick={this.onHandleSorting.bind(this, 'full_name' ,filters.full_name.sort_by)}>Name</th>
                                    <th scope="col" className={ClassNames({'sorting': !filters.phone.sort_by}, {'sorting_desc': filters.phone.sort_by == 'DESC' },{'sorting_asc': filters.phone.sort_by == 'ASC' })} onClick={this.onHandleSorting.bind(this, 'phone' ,filters.phone.sort_by)}>Phone</th>
                                    <th scope="col" className={ClassNames({'sorting': !filters.email.sort_by}, {'sorting_desc': filters.email.sort_by == 'DESC'},{'sorting_asc': filters.email.sort_by == 'ASC'})} onClick={this.onHandleSorting.bind(this, 'email' ,filters.email.sort_by)}>Email</th>
                                    <th scope="col" className={ClassNames({'sorting': !filters.customer_balance.sort_by },{'th-id':'th-balance'},{'sorting_desc': filters.customer_balance.sort_by == 'DESC'},{'sorting_asc': filters.customer_balance.sort_by == 'ASC'})} onClick={this.onHandleSorting.bind(this,'customer_balance' ,filters.customer_balance.sort_by)}>Balance</th>
                                    <th scope="col" className={ClassNames({'sorting': !filters.is_special_customer.sort_by},{'sorting_desc': filters.is_special_customer.sort_by == 'DESC'},{'sorting_asc': filters.is_special_customer.sort_by == 'ASC'})} onClick={this.onHandleSorting.bind(this, 'is_special_customer' ,filters.is_special_customer.sort_by)}>Special customer</th>
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
