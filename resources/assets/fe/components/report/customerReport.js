import React, { Component } from 'react'
import ClassNames from "classnames";
import * as _ from "lodash";
import {requestFilter, requestGetList} from "../../actions/report/customer";
import Loading from "../layout/loading";
import Pagination from "react-js-pagination";
import DatePicker from 'react-datepicker'
import moment from 'frozen-moment';
import Api from '../../api'
import XLSX from 'xlsx'
import FilterFromTo from '../helper/filterFromTo';

export default class CustomerReport extends Component{

    constructor(props){
        super(props);
        this.state = {
            isFetching: false,
            customersReport: this.props.customersReport,
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
        this.onExport = this.onExport.bind(this)
    }

    componentWillMount(){
        if(_.isEmpty(this.state.customersReport)){
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

    async onExport(){
        this.setState({
            isFetching: true
        });
        const data = await Api.requestExportCustomers(this.props.jwt, this.state.filters)
        const result = JSON.parse(data.text);

        if(result.status){
            const tHead = [["ID", "ID employee", "Employee", "Full name", "Phone", "Email", "Balance", "Special customer", "Active", "Type"]];
            _.values(result.data.items).forEach((item) => {
                tHead.push(item)
            })
            const wb = XLSX.utils.book_new()
            const wsAll = XLSX.utils.aoa_to_sheet(tHead);
            XLSX.utils.book_append_sheet(wb, wsAll, "All Customer")
            XLSX.writeFile(wb, "customers.xlsx")

            this.setState({
                isFetching: false,
            })

        }else{
            alert(response.msg)
        }
    }

    renderList(){
        const {isFetching, customers, actions,itemsPerPage , currentPage, totalItems, filters } = this.state;

        let customerList;
        if(!_.isEmpty(customers) && !isFetching) {
            customerList = customers.map((customer) =>
                <tr key={customer.id}>
                    <td>{customer.id}</td>
                    <td>{customer.employee_name}</td>
                    <td>{customer.full_name}</td>
                    <td>{customer.phone}</td>
                    <td>{customer.email}</td>
                    <td>{customer.customer_balance}</td>
                    <td>{customer.is_special_customer ? <span className="label label-success">Special</span> : ''}</td>
                    <td>
                        <button type="button"
                                className={ClassNames("btn btn-block btn-sm ", {'btn-success': customer.status}, {'btn-warning': !customer.status})}> {customer.status ? 'Active' : 'Inactive'}</button>
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
                <div className="filter-report-customer">
                    <div className="filter-report">
                        <FilterFromTo filter={filters} onChangeDate={this.onChangeDate} />
                       <button className="btn-filter" onClick={this.onRequestFitler.bind(this)}> <i className={'fa fa-filter'}></i></button>
                    </div>
                    <div className="btn-export-excel">
                        <button onClick={this.onExport.bind(this)}>Export</button>
                    </div>
                </div>
                <div className="box-body list-product-report">
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
                                <th scope="col" className={ClassNames({'sorting': !filters.is_special_customer.sort_by},{'sorting_desc': filters.is_special_customer.sort_by == 'DESC'},{'sorting_asc': filters.is_special_customer.sort_by == 'ASC'})} onClick={this.onHandleSorting.bind(this, 'is_special_customer' ,filters.is_special_customer.sort_by)}>Special customer</th>
                                <th scope="col" className={ClassNames({'sorting': !filters.status.sort_by },{'sorting_desc': filters.status.sort_by == 'DESC'},{'sorting_asc': filters.status.sort_by == 'ASC'})} onClick={this.onHandleSorting.bind(this, 'status' , filters.status.sort_by)}>Status</th>
                            </tr>
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
            return <Loading />
        }
        return (
            <div>
                {this.renderList()}
            </div>
        );
    }

}
