import React, { Component } from 'react';
import Loading from "../layout/loading";
import {requestFilter, requestGetList} from "../../actions/workprofile";
import * as _ from 'lodash'
import ClassNames from 'classnames'
import Pagination from "react-js-pagination";
import { Link } from 'react-router-dom'
import {hasRole} from "../../utility";
import DatePicker from "react-datepicker/es";
import moment from "frozen-moment";
import FilterFromTo from "../helper/filterFromTo";

export default class WorkProfile extends Component{
    constructor(props){
        super(props);
        this.state = {
            isFetching: false,
            workProfiles: this.props.workProfiles,
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
        this.onChangeDate = this.onChangeDate.bind(this);
    }

    componentWillMount(){
        if(_.isEmpty(this.state.workProfiles)){
            this.setState({
                isFetching: true
            });
            this.props.dispatch(requestGetList(this.props.jwt));
        }
    }

    componentWillReceiveProps(nextProps){
        if(nextProps.workProfiles){
            this.setState({
                workProfiles: nextProps.workProfiles,
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
          if(k != field && k != 'from' && k!='to'){
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

    onChangeDate(field, date) {
        this.setState({
            filters: Object.assign({}, this.state.filters, {
                [field]: date.format('YYYY-MM-DD 23:59:59')
            })
        });
    }

    renderList(){
        const {isFetching, workProfiles, actions,itemsPerPage , currentPage, totalItems, filters } = this.state;
            const filterData = (
                <tr>
                    <th scope="col">
                        <input type="search" name='id' value={filters.id.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange} />
                    </th>
                    <th scope="col">
                        <input type="search" name='title' value={filters.title.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/>
                    </th>
                    <th scope="col">
                        <input type="search" name='employee_name' value={filters.employee_name.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/>
                    </th>
                    <th scope="col">
                        <input type="search" name='status' value={filters.status.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/>
                    </th>
                    <th scope="col">
                        <input type="search" name='id_procedure' value={filters.id_procedure.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/>
                    </th>
                    <th scope="col">
                        <input type="search" name='work_category_name' value={filters.work_category_name.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/>
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
            let workProfileList;
        if(!_.isEmpty(workProfiles) && !isFetching) {
            workProfileList = workProfiles.map((workProfile) =>
                <tr key={workProfile.id}>
                    <td>{workProfile.id}</td>
                    <td>{workProfile.title}</td>
                    <td>{workProfile.employee_name}</td>
                    <td>{workProfile.status}</td>
                    <td>{workProfile.id_procedure}</td>
                    <td>{workProfile.work_category_name}</td>
                    <td colSpan={2}>
                        <Link to={'/work-profile/edit/'+workProfile.id} className="btn btn-block btn-sm">
                            <i className={'fa fa-edit'}></i>
                        </Link>
                    </td>
                </tr>
            )
        }
        else{
            workProfileList = (
                    <div>
                        <h3>Work Profile not found</h3>
                    </div>
                )
            }

            return (
                <div className="box box-primary">
                    <div className="box-header with-border text-center">
                        <h3 className="">Work Profile</h3>
                    </div>
                    <div className="filter-report">
                        <FilterFromTo filter={filters} onChangeDate={this.onChangeDate}/>
                        <button className="btn-filter" onClick={this.onRequestFitler.bind(this)}> <i className={'fa fa-filter'}></i></button>
                    </div>
                    <div className="box-body">
                        <div className={ClassNames({'btn-add-custom': true}, {'hidden' : !hasRole('add-workprofile', actions)})}>
                            <Link to={'work-profile/add'} className='btn btn-fat add-profile'>
                                <i className='fa fa-plus'></i> Add Work Profile
                            </Link>
                            <Link to={'work-profile/kanban'} className='btn btn-fat'>
                                <i className='fa fa-eye'></i> View kanban
                            </Link>
                        </div>
                        <div className="table-responsive clear-fix">
                            <table className="table table-hover dataTable">
                                <thead>
                                <tr>
                                    <th scope="col" className={ClassNames({'sorting': !filters.id.sort_by },{'th-id':'th-id'}, {'sorting_desc': filters.id.sort_by == 'DESC' },{'sorting_asc': filters.id.sort_by == 'ASC' } )} onClick={this.onHandleSorting.bind(this, 'id' ,filters.id.sort_by)}>ID</th>
                                    <th scope="col" className={ClassNames({'sorting': !filters.title .sort_by}, {'sorting_desc': filters.title.sort_by == 'DESC'},{'sorting_asc': filters.title.sort_by == 'ASC'})} onClick={this.onHandleSorting.bind(this, 'title' ,filters.title.sort_by)}>Title</th>
                                    <th scope="col" className={ClassNames({'sorting': !filters.employee_name.sort_by},{'th-id':'th-employ'}, {'sorting_desc': filters.employee_name.sort_by == 'DESC' },{'sorting_asc': filters.employee_name.sort_by == 'ASC' }, )} onClick={this.onHandleSorting.bind(this, 'employee_name' ,filters.employee_name.sort_by)}>Employee</th>
                                    <th scope="col" className={ClassNames({'sorting': !filters.status.sort_by},{'sorting_desc': filters.status.sort_by == 'DESC'},{'sorting_asc': filters.status.sort_by == 'ASC' })} onClick={this.onHandleSorting.bind(this, 'status' ,filters.status.sort_by)}>Status</th>
                                    <th scope="col" className={ClassNames({'sorting': !filters.id_procedure.sort_by}, {'sorting_desc': filters.id_procedure.sort_by == 'DESC' },{'sorting_asc': filters.id_procedure.sort_by == 'ASC' })} onClick={this.onHandleSorting.bind(this, 'id_procedure' ,filters.id_procedure.sort_by)}>Procedure</th>
                                    <th scope="col" className={ClassNames({'sorting': !filters.work_category_name.sort_by },{'sorting_desc': filters.work_category_name.sort_by == 'DESC'},{'sorting_asc': filters.work_category_name.sort_by == 'ASC'})} onClick={this.onHandleSorting.bind(this, 'work_category_name' , filters.work_category_name.sort_by)}>Work Category Name</th>
                                    <th scope="col">Action</th>
                                </tr>
                                {filterData}
                                </thead>
                                <tbody>
                                  {workProfileList}
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
        const { isFetching, actions } = this.state;
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
