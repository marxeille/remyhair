import React, { Component } from 'react'
import * as _ from 'lodash'
import Input from "../partial/input";
import Loading  from '../layout/loading'
import Api from '../../api'
import ClassNames from 'classnames'
import {receiveList} from "../../actions/customer";

export default class EditProcedure extends Component{
    constructor(props) {
        super(props);
        const procedureSteps =  _.filter(this.props.procedureSteps, (procedureStep) => {
            return procedureStep.id_procedure ==  this.props.form.id_procedure
        });
        const selected = _.size(this.props.value) ? this.props.value : {
            id_procedure: _.first(this.props.procedures).id,
            id_status: (_.first(procedureSteps)) ? _.first(procedureSteps).id : null,
        };

        this.props.onChangeProcedures.bind(selected);
        this.errors = 'Procedure field is requried';
        this.state = {
            isFetching:false,
            procedures: this.props.procedures,
            procedureSteps: procedureSteps,
            selected: selected,
            error: this.props.error
        };
    }

    onSelectProcedure(event){
        const procedureSteps =  _.filter(this.props.procedureSteps, (procedureStep) => {
            return procedureStep.id_procedure == event.target.value
        });
        const state = {
            procedureSteps: procedureSteps,
            selected: Object.assign({}, this.state.selected, {
                [event.target.name]: event.target.value,
                id_status: _.first(procedureSteps).id,
            })
        };
        this.setState(state);
    }

    onSelectProcedureStep(event){
        const state = {
            selected: Object.assign({}, this.state.selected, {
                [event.target.name]: event.target.value
            })
        };
        this.setState(state);
    }

    onChangeProcedures(event){
        this.setState({
            selected : Object.assign( this.state.selected, {
                [event.target.name]: event.target.value,
            }),
            error: (!event.target.value) ? this.errors : ''
        })
    }

    componentDidUpdate(prevProps, prevState, snapshot){
        if(prevProps == this.props){
            this.props.onChangeProcedures(this.state.selected);
        }
    }


    render() {
        const {procedures } = this.props;
        const { procedureSteps } = this.state;
        return(
            <div>
                <div className={ClassNames({'form-group': true})}>
                <label>Procedures *</label>
                <select name="id_procedure" id="" className={'form-control'} value={this.props.form.id_procedure} onChange={this.onSelectProcedure.bind(this)}>
                    {procedures.map((procedure)=>(
                        <option value={procedure.id} key={procedure.id}>{procedure.title}</option>
                    ))}
                </select>
                </div>

                <div className={ClassNames({'form-group': true})}>
                <label>Procedure steps *</label>
                <select name="id_status" id="" className={'form-control'} value={this.props.form.id_status} onChange={this.onSelectProcedureStep.bind(this)}>
                    {procedureSteps.map((procedureStep)=>(
                        <option value={procedureStep.id} key={procedureStep.id}>{procedureStep.name}</option>
                    ))}
                </select>
                </div>
            </div>
        )
    }

}
