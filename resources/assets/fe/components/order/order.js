import React, { Component } from 'react';
import Loading from "../layout/loading";
import {requestFilter, requestGetList} from "../../actions/order";
import * as _ from 'lodash'
import ClassNames from 'classnames'
import Pagination from "react-js-pagination";
import { Link } from 'react-router-dom'
import {hasRole, showPrice} from "../../utility";
import FilterFromTo from "../helper/filterFromTo";
import Api from '../../api'
import {receiveInitCart} from "../../actions/order/cart";

export default class Order extends Component{
    constructor(props){
        super(props);
        this.state = {
            isFetching: false,
            orders: this.props.orders,
            pageLimit: this.props.pageLimit,
            currentPage: this.props.currentPage,
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
        this.onChangeFilterDate = this.onChangeFilterDate.bind(this);
        this.handleEditOrder = this.handleEditOrder.bind(this);
    }

    componentWillMount(){
        if(_.isEmpty(this.state.orders)){
            this.setState({
                isFetching: true
            });
            this.props.dispatch(requestGetList(this.props.jwt));
        }
    }

    componentWillReceiveProps(nextProps){
        if(nextProps.orders){
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
    }

    handlePageChange(pageNumber){
        if(pageNumber){
            this.setState({
                isFetching: true
            });
            this.props.dispatch(requestFilter({
                jwt: this.props.jwt,
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
            if(k != field && k!= 'from' && k!='to'){
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
            page: 1,
            filters: filters
        }));
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

    async handleEditOrder(order){
        if(hasRole('edit-order/get-cart', this.props.actions)){
            this.setState({
                isFetching: true
            });
            try{
                const response = await Api.initEditCart({
                    idOrder: order.id,
                    idCart: order.id_cart
                }, this.props.jwt);
                const result = JSON.parse(response.text);
                result.status ? this.props.dispatch(receiveInitCart(result.data)) : alert('Something went wrong');
                this.props.history.push('/sale')
            }catch(err){
                alert('Something went wrong');
            }
        }else{
            alert('You have no permission')
        }
    }

    onChangeFilterDate(field, date) {
        this.setState({
            filters: Object.assign({}, this.state.filters, {
                [field]: date.format('YYYY-MM-DD 23:59:59')
            })
        });
    }

    renderList(){
        const {isFetching, orders, actions,itemsPerPage , currentPage, totalItems, filters } = this.state;
        const { payments, order_status, employees } = this.props;
        const filterData = (
            <tr>
                <th scope="col">
                    <input type="search" name='id' value={filters.id.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange} />
                </th>
                <th scope="col">
                    <select name="saleman" className="form-control" value={filters.saleman.value} onChange={this.onHandleFilterTextChange.bind(this)}>
                        <option value="" ></option>
                        {employees.map((employee) => (
                            <option value={employee.name} key={employee.id}>{employee.name}</option>
                        ))}
                    </select>
                    {/* <input type="search" name='saleman' value={filters.saleman.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/> */}
                </th>
                <th scope="col">
                    <input type="search" name='customer' value={filters.customer.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/>
                </th>
                <th scope="col">
                    <select name="status" className="form-control" value={filters.status.value} onChange={this.onHandleFilterTextChange.bind(this)}>
                        <option value="" ></option>
                        {order_status.map((status) => (
                            <option value={status} key={status}>{status}</option>
                        ))}
                    </select>
                    {/* <input type="search" name='status' value={filters.status.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/> */}
                </th>
                <th scope="col">
                    <select name="payment" className="form-control" value={filters.payment.value} onChange={this.onHandleFilterTextChange.bind(this)}>
                        <option value="" ></option>
                        {payments.map((payment) => (
                            <option value={payment.name} key={payment.id}>{payment.name}</option>
                        ))}
                    </select>
                    {/* <input type="search" name='payment' value={filters.payment.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/> */}
                </th>
                <th scope="col">
                    <input type="search" name='total_paid' value={filters.total_paid.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/>
                </th>
                 <th scope="col">
                    <input type="search" name='total_unpaid' value={filters.total_unpaid.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/>
                </th>
               
                <th scope="col">
                    <select name="type" className="form-control" value={filters.type.value} onChange={this.onHandleFilterTextChange.bind(this)}>
                        <option value="" ></option>
                        <option value="1">Canceled</option>
                        <option value="2">Refunded</option>
                    </select>
                    {/* <input type="search" name='payment' value={filters.payment.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/> */}
                </th>
                <th scope="col">
                    <input type="search" name='created_at' value={filters.created_at.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/>
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
        let orderList;
        if(!_.isEmpty(orders) && !isFetching) {
            orderList = orders.map((order) =>{
                let currentStatus = null;
                switch (order.current_status) {
                    case 3:
                        currentStatus = 'song-hang';
                        break;
                    case 5:
                        currentStatus = 'rut';
                        break;
                    case 6:
                        currentStatus = 'can-hang';
                        break;
                    case 7:
                        currentStatus = 'steam';
                        break;
                    case 8:
                        currentStatus = 'tay-nhuom';
                        break;
                    case 9:
                        currentStatus = 'finished';
                        break;
                    default:
                        currentStatus = 'made-order';
                        break;
                }

                return (<tr key={order.id}>
                        <td><Link to={`/order/${order.id}`}>{order.id}</Link></td>
                        <td><Link to={`/order/${order.id}`}>{order.saleman}</Link></td>
                        <td><Link to={`/order/${order.id}`}>{order.customer}</Link></td>
                        <td className={ClassNames("status", currentStatus)}><Link to={`/order/${order.id}`}>{order.status}</Link></td>
                        <td><Link to={`/order/${order.id}`}>{order.payment}</Link></td>
                        <td><Link to={`/order/${order.id}`}>{showPrice(order.total_paid)}</Link></td>
                        <td><Link to={`/order/${order.id}`}>{showPrice(order.total_unpaid)}</Link></td>
                        <td><Link to={`/order/${order.id}`}>{order.type > 0 ? order.type ==1 ? 'Canceled' : 'Refunded' : '--'}</Link></td>
                        <td><Link to={`/order/${order.id}`}>{order.created_at}</Link></td>
                        {hasRole('edit-order/get-cart', this.props.actions) &&
                        <button type="button" onClick={() => this.handleEditOrder(order)} className="btn btn-success">
                            <i className="fa fa-credit-card"></i> Edit
                        </button>
                        }
                </tr>)
            })
                    
            
        }
        else{
            orderList = (
                <div>
                    <h3>No Order</h3>
                </div>
            )
        }

        return (
            <div className="box box-primary">
                <div className="box-header with-border text-center">
                    <h3 className="">Order</h3>
                </div>
                <div className="filter-report">
                    <FilterFromTo filter={filters} onChangeDate={this.onChangeFilterDate} />
                    <button className="btn-filter" onClick={this.onRequestFitler.bind(this)}> <i className={'fa fa-filter'}></i></button>
                </div>
                <div className="box-body">
                    <div className={ClassNames({'btn-add-custom': true}, {'hidden' : !hasRole('add-workprofile', actions)})}>
                        <Link to={'order/kanban'} className='btn btn-fat'>
                            <i className='fa fa-eye'></i> View kanban
                        </Link>
                    </div>
                    <div className="table-responsive clear-fix">
                        <table className="table table-hover dataTable order-table">
                            <thead>
                            <tr>
                                <th scope="col" className={ClassNames({'sorting': !filters.id.sort_by },{'th-id':'th-id'}, {'sorting_desc': filters.id.sort_by == 'DESC' },{'sorting_asc': filters.id.sort_by == 'ASC' } )} onClick={this.onHandleSorting.bind(this, 'id' ,filters.id.sort_by)}>ID</th>
                                <th scope="col" className={ClassNames({'sorting': !filters.saleman .sort_by}, {'sorting_desc': filters.saleman.sort_by == 'DESC'},{'sorting_asc': filters.saleman.sort_by == 'ASC'})} onClick={this.onHandleSorting.bind(this, 'saleman' ,filters.saleman.sort_by)}>Saleman</th>
                                <th scope="col" className={ClassNames({'sorting': !filters.customer.sort_by},{'th-id':'th-employ'}, {'sorting_desc': filters.customer.sort_by == 'DESC' },{'sorting_asc': filters.customer.sort_by == 'ASC' }, )} onClick={this.onHandleSorting.bind(this, 'customer' ,filters.customer.sort_by)}>Customer</th>
                                <th scope="col" className={ClassNames({'sorting': !filters.status.sort_by},{'sorting_desc': filters.status.sort_by == 'DESC'},{'sorting_asc': filters.status.sort_by == 'ASC' })} onClick={this.onHandleSorting.bind(this, 'status' ,filters.status.sort_by)}>Status</th>
                                <th scope="col" className={ClassNames({'sorting': !filters.payment.sort_by}, {'sorting_desc': filters.payment.sort_by == 'DESC' },{'sorting_asc': filters.payment.sort_by == 'ASC' })} onClick={this.onHandleSorting.bind(this, 'payment' ,filters.payment.sort_by)}>Payment</th>
                                <th scope="col" className={ClassNames({'sorting': !filters.total_paid.sort_by },{'sorting_desc': filters.total_paid.sort_by == 'DESC'},{'sorting_asc': filters.total_paid.sort_by == 'ASC'})} onClick={this.onHandleSorting.bind(this, 'total_paid' , filters.total_paid.sort_by)}>Total paid</th>
                                <th scope="col" className={ClassNames({'sorting': !filters.total_unpaid.sort_by },{'sorting_desc': filters.total_unpaid.sort_by == 'DESC'},{'sorting_asc': filters.total_unpaid.sort_by == 'ASC'})} onClick={this.onHandleSorting.bind(this, 'total_unpaid' , filters.total_unpaid.sort_by)}>Total unpaid</th>
                                <th scope="col" className={ClassNames({'sorting': !filters.type.sort_by },{'sorting_desc': filters.type.sort_by == 'DESC'},{'sorting_asc': filters.type.sort_by == 'ASC'})} onClick={this.onHandleSorting.bind(this, 'type' , filters.type.sort_by)}>Type</th>
                                <th scope="col" className={ClassNames({'sorting': !filters.created_at.sort_by },{'sorting_desc': filters.created_at.sort_by == 'DESC'},{'sorting_asc': filters.created_at.sort_by == 'ASC'})} onClick={this.onHandleSorting.bind(this, 'created_at' , filters.created_at.sort_by)}>Created at</th>
                                <th scope="col">Action</th>
                            </tr>
                            {filterData}
                            </thead>
                            <tbody>
                            {orderList}
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
