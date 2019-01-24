import React, { Component } from 'react';
import Loading from "../layout/loading";
import {requestFilter, requestGetList, requestGetListForKanban, requestFilterKanban, requestUpdateState } from "../../actions/workprofile";
import * as _ from 'lodash'
import KanbanTable from "../../containers/workprofile/kanbanTable";


export default class WorkProfileKanbanView extends Component{
    constructor(props){
        super(props);
        this.state = {
            isFetching: false,
            workProfiles: this.props.workProfiles,
            pageLimit: this.props.pageLimit,
            currentPage: this.props.currentPage,
            jwt: this.props.jwt,
            totalItems: this.props.totalItems,
            itemsPerPage: this.props.itemsPerPage,
            filters: this.props.filters,
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
        if(nextProps.workProfiles){
            this.setState({
                workProfiles: nextProps.workProfiles,
                kanbanData: nextProps.kanbanData,
                isFetching: false
            });
        }
    }

    renderList(){
        const {isFetching ,workProfiles, kanbanData } = this.state;
        let workProfileList;
        if(!isFetching) {
            workProfileList = <KanbanTable data={kanbanData}  jwt={this.props.jwt} items={this.state.workProfiles} dispatch = {this.props.dispatch} />
        }

        return (
            <div className="box box-primary">
                <div className="box-header with-border text-center">
                    <h3 className="">Work Profile</h3>
                </div>
                <div className="box-body">
                    <div className="table-responsive table-fitter-profile">
                        {workProfileList}
                    </div>
                </div>
                <button type="button" onClick={() => this.props.history.push('/work-profile')} className="btn btn-default">Back</button>
            </div>
        );
    }

    render() {
        const { isFetching, filters } = this.state;
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
