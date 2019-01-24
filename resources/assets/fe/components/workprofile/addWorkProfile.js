import React, { Component } from 'react'
import Loading  from '../layout/loading'
import ClassNames from 'classnames'
import Api from '../../api'
import * as _ from 'lodash'
import Input from "../partial/input";
import {receiveAddWorkProfile, requestGetList, sendEmail} from "../../actions/workprofile";

export default class AddWorkProfile extends Component{
	constructor(props) {
        super(props);
        if(_.isEmpty(this.props.procedures)){
            alert('you must add procedure before add work profile')
        }
        const selected = _.size(this.props.value) ? this.props.value : {
            id_leader: _.first(this.props.employees).id,
            id_procedure: _.first(this.props.procedures).id,
            id_work_category: _.first(this.props.workCategories).id,
            id_status: _.first(this.props.procedureSteps).id,
        };
  
        this.state = {
            isFetching: false,
            selected: selected,
            procedureSteps: '',
            errors: [],
            form: {
                id_employee: this.props.employee.id,
                title: '',
                case: '',
                result: '',
                experience: '',
                hard: '',
                need_change: '',
                id_leader: selected.id_leader,
                id_procedure: selected.id_procedure,
                id_work_category: selected.id_work_category,
                id_status: selected.id_status,
                filters: this.props.filters,
                page_number: this.props.page_number
            }
        };
        this.errorMsg = 'Field is required';
        this.onChangeValue = this.onChangeValue.bind(this);
    }

    componentWillMount() {
        const procedureSteps =  _.filter(this.props.procedureSteps, (procedureStep) => {
            return procedureStep.id_procedure == this.state.form.id_procedure;
        });
        this.setState({
            procedureSteps: procedureSteps,
            form: Object.assign({}, this.state.form, {
                id_status: _.first(procedureSteps).id,
            })
        });
    }

    async onSubmit(){
	    const { form } = this.state;
        const errors = {
            title: !form.title ? this.errorMsg : '',
        };
        if(_.size(_.filter(errors, (error) => {
            return error;
        }))){
           this.setState({
               errors: errors
           })
        }else{
           this.setState({
               isFetching: true
           });
           try{
            Api.addWorkProfile(this.props.jwt, form)
                .then(response => { 
                    this.setState({
                        isFetching: false,
                    });
                    const result = JSON.parse(response.text);
                    if(!_.isEmpty(this.props.workProfiles)){
                        const workProfiles = _.concat(this.props.workProfiles, result.data.work_profile);
                        this.props.dispatch(receiveAddWorkProfile(workProfiles));
                        
                    }else{
                        this.props.dispatch(requestGetList(this.props.jwt));
                    }
                    this.props.history.push('/work-profile')                    
                 });
           }catch(errors){
               alert(errors.message)
           }
        }
    }

    onChangeValue(require, event) {
        const state = {
            form: Object.assign({}, this.state.form, {
                [event.target.name]: event.target.value
            })
        };
        if (require) {
            state.errors = Object.assign({}, this.state.errors, {
                [event.target.name]: !event.target.value
                    ? this.errorMsg
                    : ""
            });
        }
        this.setState(state);
    }

    onSelectProcedure(event){
        const procedureSteps =  _.filter(this.props.procedureSteps, (procedureStep) => {
            return procedureStep.id_procedure == event.target.value
        });
        const state = {
            procedureSteps: procedureSteps,
            form: Object.assign({}, this.state.form, {
                [event.target.name]: event.target.value,
                id_status: _.first(procedureSteps).id,
            })
        };
        this.setState(state);
    }

    onSelectProcedureStep(event){
        const state = {
            form: Object.assign({}, this.state.form, {
                [event.target.name]: event.target.value
            })
        };
        this.setState(state);
    }


    render(){
        const { types, form, isFetching, errors, procedureSteps } = this.state;
        const { employees, workCategories, procedures} = this.props;
	    if(isFetching) return <Loading/>
        return(
            <div className="">
                <div className="box box-primary">
                    <div className="box-header text-center">
                        <h4>Add Work Profile Page</h4>
                    </div>

                    <div className="box-header text-center">
                        <span>Content</span>
                    </div>
                    <form>
                    <div className="box-body" >
                        <Input
                            onChangeValue={this.onChangeValue.bind(
                                this, 
                                true
                            )}
                            title={"Title *"}
                            name={"title"}
                            placeholder={"Enter title"}
                            error={errors.title}
                            type={"text"}
                            value={form.title}
                        />
                        {/*<div className={ClassNames({'form-group': true})}>*/}
                            {/*<label>Case</label>*/}
                            {/*<textarea */}
                                {/*className="form-control"    */}
                                {/*defaultValue={form.case}*/}
                                {/*onChange={this.onChangeValue.bind(this, false)} */}
                            {/*/>*/}
                        {/*</div> */}
                        {/*<div className={ClassNames({'form-group': true})}>*/}
                            {/*<label>Result</label>*/}
                            {/*<textarea */}
                                {/*className="form-control"    */}
                                {/*defaultValue={form.result}*/}
                                {/*onChange={this.onChangeValue.bind(this, false)} */}
                            {/*/>*/}
                        {/*</div> */}
                        {/*<div className={ClassNames({'form-group': true})}>*/}
                            {/*<label>Experience</label>*/}
                            {/*<textarea */}
                                {/*className="form-control"    */}
                                {/*defaultValue={form.experience}*/}
                                {/*onChange={this.onChangeValue.bind(this, false)} */}
                            {/*/>*/}
                        {/*</div>         */}
                       
                        <div className={ClassNames({'form-group': true})}>
                            <label>Leader *</label>
                            <select name="id_leader" id="" className={'form-control'} defaultValue={this.state.selected.id_leader} onChange={this.onChangeValue.bind(this, false)}>
                                {employees.map((employee)=>(
                                    <option value={employee.id} key={employee.id}>{employee.name}</option>
                                ))}
                            </select>
                        </div>

                        <div className={ClassNames({'form-group': true})}>
                            <label>Work Categories *</label>
                            <select name="id_work_category" id="" className={'form-control'} defaultValue={this.state.selected.id_work_category} onChange={this.onChangeValue.bind(this, false)}>
                                {workCategories.map((workCategory)=>(
                                    <option value={workCategory.id} key={workCategory.id}>{workCategory.title}</option>
                                ))}
                            </select>
                        </div>

                        <div className={ClassNames({'form-group': true})}>
                            <label>Procedure *</label>
                            <select name="id_procedure" id="" className={'form-control'} defaultValue={this.state.selected.id_procedure} onChange={this.onSelectProcedure.bind(this)}>
                                {procedures.map((procedure)=>(
                                    <option value={procedure.id} key={procedure.id}>{procedure.title}</option>
                                ))}
                            </select>
                        </div>

                        <div className={ClassNames({'form-group': true})}>
                            <label>Procedure steps*</label>
                            <select name="id_status" id="" className={'form-control'} defaultValue={this.state.selected.id_status} onChange={this.onSelectProcedureStep.bind(this)}>
                                {procedureSteps.map((procedureStep)=>(
                                    <option value={procedureStep.id} key={procedureStep.id}>{procedureStep.name}</option>
                                ))}
                            </select>
                        </div>

                        
                        <div className={ClassNames({'form-group': true})}>
                            <label>Hard</label>
                            <textarea 
                                className="form-control"    
                                defaultValue={form.hard}
                                name={'hard'}
                                onChange={this.onChangeValue.bind(this, false)}
                            />
                        </div>

                            {/*<div className={ClassNames({'form-group': true})}>*/}
                                {/*<label>Need change</label>*/}
                                {/*<textarea */}
                                    {/*className="form-control"    */}
                                    {/*defaultValue={form.need_change}*/}
                                    {/*onChange={this.onChangeValue.bind(this, false)} */}
                                {/*/>*/}
                            {/*</div>                       */}
                    </div>
                        <div className="box-footer">
                            <button type="button" onClick={() => this.props.history.push('/work-profile')} className="btn btn-default">Back</button>
                            <button type="button" onClick={this.onSubmit.bind(this)} className="btn btn-info pull-right">Save</button>
                        </div>
                    </form>

                </div>
            </div>
        )
    }
}

