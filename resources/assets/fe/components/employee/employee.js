import React, { Component } from 'react';
import { Link } from 'react-router-dom'
import ClassNames from "classnames";
import {hasRole} from "../../utility";
import * as _ from "lodash";
import {requestFilter, requestGetList} from "../../actions/employee";
import Pagination from "react-js-pagination";
import Loading from "../layout/loading";
import moment from 'frozen-moment';
import DatePicker from "react-datepicker/es";
import Api from "../../api";
import FilterFromTo from "../helper/filterFromTo";

export default class Employee extends Component {

    constructor(props){
        super(props);
        this.state = {
            actions: this.props.actions,
            isFetching: false,
            employees: this.props.employees,
            employee: this.props.employee,
            pageLimit: this.props.pageLimit,
            currentPage: this.props.currentPage,
            jwt: this.props.jwt,
            totalItems: this.props.totalItems,
            itemsPerPage: this.props.itemsPerPage,
            filters: this.props.filters,
            groups: this.props.groups,
        };
        this.onHandleFilterTextChange = this.onHandleFilterTextChange.bind(this);
        this.handlePageChange = this.handlePageChange.bind(this);
        this.onHandleSorting = this.onHandleSorting.bind(this);
        this.onRequestResetFitler = this.onRequestResetFitler.bind(this);
        this.onRequestFitler = this.onRequestFitler.bind(this);
        this.onChangeFilterDate = this.onChangeFilterDate.bind(this);
    }

    componentWillMount(){
        this.setState({
            isFetching: true
        });
        this.props.dispatch(requestGetList(this.props.jwt));
    }

    componentWillReceiveProps(nextProps){
        if(nextProps.employees){
            this.setState({
                employees: nextProps.employees,
                currentPage: nextProps.currentPage,
                pageLimit: nextProps.pageLimit,
                itemsPerPage: nextProps.itemsPerPage,
                totalItems: nextProps.totalItems, filters: nextProps.filters,
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
        const fieldChange = Object.assign({}, this.state.filters[field], {
            value: date.format('YYYY-MM-DD 23:59:59')
        });
        this.setState({
            filters: Object.assign({}, this.state.filters, {
                [field] : fieldChange
            })
        });
    }

    onChangeFilterDate(field, date) {
        this.setState({
            filters: Object.assign({}, this.state.filters, {
                [field]: date.format('YYYY-MM-DD 23:59:59')
            })
        });
    }

    handChangeStatus(idEmployee, active){
        Api.changeStatusEmployee(idEmployee, active).then((response) => {
            const result = JSON.parse(response.text);
            const employees = _.filter(this.state.employees);
            if(result.status){
                this.props.dispatch(requestGetList(this.props.jwt));
                this.setState({
                    isFetching: false,
                    employees: employees
                })
            }else{
                this.setState({
                    isFetching: true,
                    errors: result.data,
                })
            }
        }).catch((errors)=>{
            alert(errors.message)
        })
    }

    renderList(){
        const {isFetching, employees, actions, itemsPerPage , currentPage, totalItems, filters, groups } = this.state;
        const filterData = (
            <tr>
                <th scope="col">
                    <input type="search" name='id' value={filters.id.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange} />
                </th>
                <th scope="col">
                    <input type="search" name='name' value={filters.name.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/>
                </th>
                <th scope="col">
                    <select name='group_name' defaultValue={filters.group_name.value} className='form-control input-sm' onChange={this.onHandleFilterTextChange}>
                        <option value="null">---</option>
                        {groups.map((group) => (
                            <option value={group.name} key={group.id}>{group.name}</option>
                        ))}
                    </select>
                </th>

                <th scope="col">
                    <input type="search" name='phone' value={filters.phone.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/>
                </th>
                <th scope="col">
                    <input type="search" name='email' value={filters.email.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/>
                </th>
                <th scope="col" className="date-search">
                    <DatePicker
                        showYearDropdown
                        selected={ filters.date_of_birth.value ? moment(filters.date_of_birth.value) : null}
                        onChange={this.onChangeDate.bind(this, 'date_of_birth')}
                        className="form-control"
                    />
                </th>
                <th scope="col" className="date-search">
                    <DatePicker
                        showYearDropdown
                        selected={ filters.join_date.value ? moment(filters.join_date.value) : null}
                        onChange={this.onChangeDate.bind(this, 'join_date')}
                        className="form-control"
                    />
                </th>
                <th scope="col">
                    <select name='active' defaultValue={filters.active.value} className='form-control input-sm' onChange={this.onHandleFilterTextChange}>
                        <option value="null">---</option>
                        <option value="1">Active</option>
                        <option value="0">In active</option>
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
        let employeeList;
        if(!_.isEmpty(employees) && !isFetching) {
            employeeList = employees.map((employee) =>
                <tr key={employee.id}>
                    <td>{employee.id}</td>
                    
                    <td>
                        <Link to={'/employee/detail/'+employee.id} className="btn btn-block btn-sm">
                            {employee.name}
                        </Link>
                    </td>
                    <td>{employee.group_name}</td>
                    <td>{employee.phone}</td>
                    <td>{employee.email}</td>
                    <td>{employee.date_of_birth}</td>
                    <td>{employee.join_date}</td>
                    <td>
                        {
                            employee.active 
                            ?
                            <button type="button" onClick = {this.handChangeStatus.bind(this, employee.id, 0)}
                                className={ClassNames("btn btn-block btn-sm ", {'btn-success': true})}> Active
                            </button>
                            :
                            <button type="button" onClick = {this.handChangeStatus.bind(this, employee.id, 1)}
                                className={ClassNames("btn btn-block btn-sm ", 'btn-warning')}> In active
                            </button>
                        }
                    </td>
                    <td >
                        <Link to={'/employee/edit/'+employee.id} className="btn btn-block btn-sm">
                            <i className={'fa fa-edit'}></i>
                        </Link>
                    </td>
                    <td></td>
                </tr>
            )
        }
        else{
            employeeList = (
                <div>
                    <h3>Employee not found</h3>
                </div>
            )
        }

        return (
            <div className="box box-primary">
                <div className="box-header with-border text-center">
                    <h3 className="">Employee</h3>
                </div>
                <div className="filter-report">
                    <FilterFromTo filter={filters} onChangeDate={this.onChangeFilterDate}/>

                    <button className="btn-filter" onClick={this.onRequestFitler.bind(this)}> <i className={'fa fa-filter'}></i></button>
                </div>
                <div className="box-body">
                    <div className={ClassNames({'btn-add-custom': true}, {'hidden' : !hasRole('add-employee', actions)})}>
                        <Link to={'employee/add'} className='btn btn-fat'>
                            <i className='fa fa-plus'></i> Add Employee
                        </Link>
                    </div>
                    <div className="table-responsive clear-fix">
                        <table className="table table-hover dataTable">
                            <thead>
                            <tr>
                                <th scope="col" className={ClassNames({'sorting': !filters.id.sort_by },{'th-id':'th-id'}, {'sorting_desc': filters.id.sort_by == 'DESC' },{'sorting_asc': filters.id.sort_by == 'ASC' } )} onClick={this.onHandleSorting.bind(this, 'id' ,filters.id.sort_by)}>ID</th>
                                <th scope="col" className={ClassNames({'sorting': !filters.name.sort_by},{'sorting_desc': filters.name.sort_by == 'DESC'},{'sorting_asc': filters.name.sort_by == 'ASC' })} onClick={this.onHandleSorting.bind(this, 'name' ,filters.name.sort_by)}>Full name</th>
                                <th scope="col" className={ClassNames({'sorting': !filters.group_name.sort_by},{'sorting_desc': filters.group_name.sort_by == 'DESC'},{'sorting_asc': filters.group_name.sort_by == 'ASC' })} onClick={this.onHandleSorting.bind(this, 'group_name' ,filters.group_name.sort_by)}>Group</th>
                                <th scope="col" className={ClassNames({'sorting': !filters.phone.sort_by}, {'sorting_desc': filters.phone.sort_by == 'DESC' },{'sorting_asc': filters.phone.sort_by == 'ASC' })} onClick={this.onHandleSorting.bind(this, 'phone' ,filters.phone.sort_by)}>Phone</th>
                                <th scope="col" className={ClassNames({'sorting': !filters.email.sort_by}, {'sorting_desc': filters.email.sort_by == 'DESC'},{'sorting_asc': filters.email.sort_by == 'ASC'})} onClick={this.onHandleSorting.bind(this, 'email' ,filters.email.sort_by)}>Email</th>
                                <th scope="col" className={ClassNames({'sorting': !filters.date_of_birth.sort_by },{'th-id':'th-balance'},{'sorting_desc': filters.date_of_birth.sort_by == 'DESC'},{'sorting_asc': filters.date_of_birth.sort_by == 'ASC'})} onClick={this.onHandleSorting.bind(this,'date_of_birth' ,filters.date_of_birth.sort_by)}>Birthday</th>
                                <th scope="col" className={ClassNames({'sorting': !filters.join_date.sort_by},{'sorting_desc': filters.join_date.sort_by == 'DESC'},{'sorting_asc': filters.join_date.sort_by == 'ASC'})} onClick={this.onHandleSorting.bind(this, 'join_date' ,filters.join_date.sort_by)}>Join date</th>
                                <th scope="col">Status</th>
                                <th scope="col">Action</th>
                            </tr>
                            {filterData}
                            </thead>
                            <tbody>
                            {employeeList}
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


