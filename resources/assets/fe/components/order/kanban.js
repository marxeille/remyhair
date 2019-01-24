import React, { Component } from 'react';
import Loading from "../layout/loading";
import {requestFilter, requestGetList, requestGetListForKanban, requestFilterKanban, requestUpdateState } from "../../actions/order";
import * as _ from 'lodash'
import ClassNames from 'classnames'
import Pagination from "react-js-pagination";
import KanbanTable from "../../containers/orderManage/kanbanTable";

export default class OrderKanbanView extends Component{
    constructor(props){
        super(props);
        this.state = {
            isFetching: false,
            orders: this.props.workProfiles,
            jwt: this.props.jwt,
            actions: this.props.actions
        };
    }

    componentWillMount(){
            this.setState({
                isFetching: true
            });
            this.props.dispatch(requestGetListForKanban({jwt: this.props.jwt}));
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
                kanbanData: nextProps.kanbanData,
                isFetching: false
            });
        }
    }

    renderList(){
        const {isFetching,orders, actions,itemsPerPage , currentPage, totalItems, filters, kanbanData } = this.state;
        let orderList;
        if(!_.isEmpty(orders) && !isFetching) {
            orderList = <KanbanTable data={kanbanData}  jwt={this.props.jwt} items={orders} dispatch = {this.props.dispatch} />
        }
        else{
            orderList = (
                <div>
                    <h3>Order not found</h3>
                </div>
            )
        }

        return (
            <div className="box box-primary">
                <div className="box-header with-border text-center">
                    <h3 className="">Order</h3>
                </div>
                <div className="box-body">
                    <div className="table-responsive table-fitter-profile">
                        {orderList}
                    </div>
                </div>
                <button type="button" onClick={() => this.props.history.push('/order')} className="btn btn-default">Back</button>
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
