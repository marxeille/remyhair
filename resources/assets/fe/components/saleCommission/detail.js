import React, { Component } from 'react';
import Loading from "../layout/loading";
import {requestDetailFilter, requestFilter, requestGetDetailList, requestGetList} from "../../actions/saleCommission";
import * as _ from 'lodash'
import ClassNames from 'classnames'
import Pagination from "react-js-pagination";
import { Link } from 'react-router-dom'

export default class DetailSaleCommission extends Component {
    constructor(props){
        super(props);
        this.state = {
            isFetching: false,
            detailSaleCommissions: this.props.detailSaleCommissions,
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
    }

    componentWillMount(){
        if(_.isEmpty(this.state.customers)){
            this.setState({
                isFetching: true
            });
            this.props.dispatch(requestGetDetailList(this.props.jwt, this.props.match.params.id));
        }
    }

    componentWillReceiveProps(nextProps){
        if(nextProps.saleCommissions){
            this.setState({
                saleCommissions: nextProps.saleCommissions,
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
            this.props.dispatch(requestDetailFilter({
                jwt: this.state.jwt,
                id:this.props.match.params.id,
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
        this.props.dispatch(requestDetailFilter({
            jwt: this.state.jwt,
            id:this.props.match.params.id,
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

        this.props.dispatch(requestDetailFilter({
            jwt: this.state.jwt,
            id:this.props.match.params.id,
            page: 1,
            filters: filters
        }));
    }

    onRequestFitler(){
        this.setState({
            isFetching: true
        });
        this.props.dispatch(requestDetailFilter({
            jwt: this.state.jwt,
            id:this.props.match.params.id,
            page: this.state.currentPage,
            filters: this.state.filters
        }));
    }

    renderList(){
        const {isFetching, saleCommissions,itemsPerPage , currentPage, totalItems, filters } = this.state;
        const filterData = (
            <tr>
                <th scope="col">
                    <input type="search" name='id' value={filters.id.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange} />
                </th>
                <th scope="col">
                    <input type="search" name='id_order' value={filters.id_order.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/>
                </th>
                <th scope="col">
                    <input type="search" name='sale_commission' value={filters.sale_commission.value} className="form-control input-sm" placeholder="" aria-controls="example1" onChange={this.onHandleFilterTextChange}/>
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
        let saleCommissionList;
        let saleman = null;
        if(!_.isEmpty(saleCommissions) && !isFetching) {
            saleman = (
                     <Link to={`/employee/detail/${_.first(saleCommissions).id_employee}`}>
                         <i className='fa fa-user'>{_.first(saleCommissions).employee_name}</i>
                     </Link>
            );
            saleCommissionList = saleCommissions.map((saleCommission) =>
                <tr key={saleCommission.id}>
                    <td>
                        {saleCommission.id}
                    </td>
                    <td>
                        {saleCommission.id_order}
                    </td>
                    <td>{saleCommission.sale_commission}</td>
                </tr>
            )
        }
        else{
            saleCommissionList = (
                <div>
                    <h3>No sale commission not found</h3>
                </div>
            )
        }

        return (
            <div className="box box-primary">
                <div className="box-header with-border text-center">
                    <h3 className="">Sale commission</h3>
                </div>
                Saleman: {saleman}
                <div className="box-body">
                    <div className="table-responsive">
                        <table className="table table-hover dataTable">
                            <thead>
                            <tr>
                                <th scope="col" className={ClassNames({'sorting': !filters.id.sort_by },{'th-id':'th-id'}, {'sorting_desc': filters.id.sort_by == 'DESC' },{'sorting_asc': filters.id.sort_by == 'ASC' } )} onClick={this.onHandleSorting.bind(this, 'id' ,filters.id.sort_by)}>ID</th>
                                <th scope="col" className={ClassNames({'sorting': !filters.id_order.sort_by},{'th-id':'th-employ'}, {'sorting_desc': filters.id_order.sort_by == 'DESC' },{'sorting_asc': filters.id_order.sort_by == 'ASC' }, )} onClick={this.onHandleSorting.bind(this, 'id_order' ,filters.id_order.sort_by)}>ID order </th>
                                <th scope="col" className={ClassNames({'sorting': !filters.sale_commission.sort_by}, {'sorting_desc': filters.sale_commission.sort_by == 'DESC' },{'sorting_asc': filters.sale_commission.sort_by == 'ASC' })} onClick={this.onHandleSorting.bind(this, 'sale_commission' ,filters.sale_commission.sort_by)}>Sale commission</th>
                            </tr>
                            {filterData}
                            </thead>
                            <tbody>
                            {saleCommissionList}
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
