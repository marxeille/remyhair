import React, { Component } from 'react';
import Loading from "../layout/loading";
import Api from '../../api'
import {receiveProcedures, requestGetProcedures} from "../../actions/workprofile";
import * as _ from 'lodash'
import EditState from "./editState";

export default class OrderState extends Component{
    constructor(props){
        super(props);
        this.state = {
            errors:{},
            states: props.states,
            loading: false
        };
        this.removeState = this.removeState.bind(this);
        this.updateState = this.updateState.bind(this);
    }

    updateState(states){
        this.setState({
            states: states
        })
    }

    componentWillReceiveProps(props){
        this.setState({
            states: props.states,
            loading: false
        })
    }

    async removeState(){
        this.setState({
            loading : true
        });
        try{
            const fetch = await Api.removeProcedure(this.props.jwt, this.state.form.id);
            const result = JSON.parse(fetch.text);
            if(result.status){
                if(!_.isEmpty(this.props.procedures)){
                    const procedures = _.filter(this.props.procedures, (procedure) => {
                        if(procedure.id != this.state.form.id){
                            return procedure
                        }
                    });
                    this.props.dispatch(receiveProcedures(procedures));
                }else{
                    this.props.dispatch(requestGetProcedures());
                }
                this.props.history.push('/procedure')
            }else{
                alert(result.msg);
                this.setState({
                    isFetching: false,
                })
            }
        }catch(errors){
            alert(errors.message)
        }
    }

    async onSubmit(){
        const { states } = this.state;
        if(_.size(_.filter(states, (state) => {
            return !state.name;
        })) == 0 ){
            this.setState({
                loading: true
            });
            try{
                const fetch = await Api.editState(this.props.jwt, this.state.states);
                const result = JSON.parse(fetch.text);
                if(!result.status){
                    alert(result.msg);
                }
                this.setState({
                    loading: false,
                })
            }catch(errors){
                alert(errors.message)
            }
        }
    }

    render(){
        const { loading, form, states } = this.state;
        return(
            <div className="editProcedureContent">
                {loading ? <Loading/> :
                    <div className="box box-primary">
                        <div className="box-header text-center">
                            <h4>Edit order states</h4>
                        </div>
                        <div className="box-body" >
                            <EditState states={states}  jwt={this.props.jwt}  updateStates={this.updateState.bind(this)}/>
                        </div>
                        <div className="box-footer">
                            <button type="button" onClick={() => this.props.history.push('/')} className="btn btn-default">Back</button>
                            <button type="button" onClick={this.onSubmit.bind(this)} className="btn btn-info pull-right">Save</button>
                        </div>
                </div> }

            </div>
        )
    }
}
