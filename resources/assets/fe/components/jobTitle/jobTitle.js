import React, { Component } from 'react';
import { Link } from 'react-router-dom'
import ClassNames from "classnames";
import {hasRole} from "../../utility";
import * as _ from "lodash";
import {requestFilter, requestGetList } from "../../actions/jobTitle";
import Pagination from "react-js-pagination";
import Loading from "../layout/loading";
import Api from '../../api'


export default class JobTitle extends Component{
    constructor(props){
        super(props);
        this.state = {
            isFetching: false,
            jobTitles: this.props.jobTitles,
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
        this.onDeleteJobTitle = this.onDeleteJobTitle.bind(this);
        this.onRequestResetFitler = this.onRequestResetFitler.bind(this);
        this.onRequestFitler = this.onRequestFitler.bind(this);
    }

    componentWillMount(){
        if(_.isEmpty(this.state.jobTitles)){
            this.setState({
                isFetching: true
            });
            this.props.dispatch(requestGetList({jwt: this.props.jwt}));
        }
    }

    
    async componentWillReceiveProps(nextProps){
        if(nextProps.jobTitles){
            this.setState({
                jobTitles: nextProps.jobTitles,
                currentPage: nextProps.currentPage,
                pageLimit: nextProps.pageLimit,
                itemsPerPage: nextProps.itemsPerPage,
                totalItems: nextProps.totalItems,
                filters: nextProps.filters,
                isFetching: false
            });
        }
        if (nextProps.match.params.type !== this.props.match.params.type) {
            const response = await this.props.dispatch(requestGetList({jwt: this.props.jwt}, nextProps.match.params.type));
            this.setState({
                isFetching: true
            });
        }
    }

    componentWillUpdate(nextProps) {
        if (nextProps.match.params.type !== this.props.match.params.type) {
            this.setState({
                payments: nextProps.payments,
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
            if(k != field){
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
            f.sort_by = null;
            f.value = ""
        });

        this.setState({
            isFetching: true,
            filters: filters
        });

        this.props.dispatch(requestFilter({
            jwt: this.state.jwt,
            page: 1,
            filters: filters,
        }));
    }

    onRequestFitler(){
        this.setState({
            isFetching: true
        });
        this.props.dispatch(requestFilter({
            jwt: this.state.jwt,
            page: this.state.currentPage,
            filters: this.state.filters,
        }));
    }

    onDeleteJobTitle(id) {
        Api.deleteJobTitle(this.props.jwt, id).then((response) => {
            const result = JSON.parse(response.text);
            if(result.status){
                const jobTitles = _.filter(this.state.jobTitles, (jobTitle) => jobTitle.id != id);

                this.setState({
                    isFetching: false,
                    jobTitles: jobTitles
                })
            }else{
                this.setState({
                    isFetching: false,
                    errors: result.data,
                });
            }
        }).catch((errors)=>{
            alert(errors.message)
        })
    }


    renderList(){
        const {isFetching, jobTitles, actions, itemsPerPage , currentPage, totalItems, filters, groups } = this.state;
        const filterData = (
            <tr>
                <th scope="col">
                    <input type="search" name='id' value={filters.id.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange} />
                </th>
                <th scope="col">
                    <input type="search" name='name' value={filters.title.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/>
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
        let jobtitleList;
        if(!_.isEmpty(jobTitles) && !isFetching) {
            jobtitleList = jobTitles.map((jobTitle) =>
                <tr key={jobTitle.id}>
                    <td>{jobTitle.id}</td>
                    <td>{jobTitle.title}</td>
                    <td colSpan={1}>
                        <Link to={'/job-title/edit/' + jobTitle.id} className="btn btn-block btn-sm">
                            <i className={'fa fa-edit'}></i>
                        </Link>
                    </td>
                    <td colSpan={1}>
                        <a 
                            onClick={() => {
                                if(confirm('Are you sure?')){
                                    this.onDeleteJobTitle.bind(this, jobTitle.id)
                                }
                            }}
                        >
                            <i className={'fa fa-trash'}></i>
                        </a>
                    </td>
                </tr>
            )
        }
        else{
            jobtitleList = (
                <div>
                    <h3>Data not found</h3>
                </div>
            )
        }

        return (
            <div className="box box-primary">
                <div className="box-header with-border text-center">
                    <h3 className="">Job title {this.props.match.params.type}</h3>
                </div>
                <div className="box-body">
                    <div className={ClassNames({'btn-add-custom': true}, {'hidden' : !hasRole('add-employee', actions)})}>
                        <Link to={'/job-title/add'} className='btn btn-fat'>
                            <i className='fa fa-plus'></i> Add job title {this.props.match.params.type}
                        </Link>
                    </div>
                    <div className="table-responsive">
                        <table className="table table-hover dataTable">
                            <thead>
                            <tr>
                                <th scope="col" className={ClassNames({'sorting': !filters.id.sort_by },{'th-id':'th-id'}, {'sorting_desc': filters.id.sort_by == 'DESC' },{'sorting_asc': filters.id.sort_by == 'ASC' } )} onClick={this.onHandleSorting.bind(this, 'id' ,filters.id.sort_by)}>ID</th>
                                <th scope="col" className={ClassNames({'sorting': !filters.title.sort_by},{'sorting_desc': filters.title.sort_by == 'DESC'},{'sorting_asc': filters.title.sort_by == 'ASC' })} onClick={this.onHandleSorting.bind(this, 'title' ,filters.title.sort_by)}>Name</th>
                                <th scope="col">Action</th>
                            </tr>
                            {filterData}
                            </thead>
                            <tbody>
                            {jobtitleList}
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
