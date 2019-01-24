import React, { Component } from 'react'
import Loading  from '../layout/loading'
import ClassNames from 'classnames'
import EditProcedure from "./editProcedure";
import Api from '../../api'
import * as _ from 'lodash'
import Input from "../partial/input";
import {receiveAddWorkProfile, requestGetList} from "../../actions/workprofile";

export default class EditWorkProfile extends Component{
	constructor(props) {
        super(props);
        const selected = {
            id_procedure: _.first(this.props.procedures).id,
            id_status: _.first(this.props.procedureSteps).id,
        };
        this.state = {
            isFetching: true,
            errors: [],
            procedureSteps: this.props.procedureSteps,
            procedures: this.props.procedures,
            title: '',
            form: {
                id_employee: this.props.employee.id,
                title: '',
                case: '',
                result: '',
                experience: '',
                hard: '',
                need_change: '',
                id_leader: '',
                id_procedure: selected.id_procedure,
                id_work_category: '',
                id_status: selected.id_status,
                filters: this.props.filters,
                page_number: this.props.page_number
            }
        };
        this.onChangeValue = this.onChangeValue.bind(this);
        this.errorMsg = 'Field is required';
    }

    async onSubmitInfomation(){
	    const { form, errors } = this.state;
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
               const fetch = await Api.editWorkProfile(this.props.jwt, form);
               const result = JSON.parse(fetch.text);
               if(result.status){
                   if(!_.isEmpty(this.props.workProfiles)){
                        const workProfiles = this.props.workProfiles.map((workProfile) => {
                            if(workProfile.id == result.data.work_profile.id){
                                    return result.data.work_profile
                            }else return workProfile
                        })
                       this.props.dispatch(receiveAddWorkProfile(workProfiles));
                   }else{
                       this.props.dispatch(requestGetList(this.props.jwt));
                   }
                   this.props.history.push('/work-profile');

               }else{
                   this.setState({
                       isFetching: false,
                       errors: Object.assign({}, this.state.errors, result.data)
                   })
               }
           }catch(errors){
               alert(errors.message)
           }
        }
    }

    async componentWillMount(){
	    const response = await Api.getWorkProfile(this.props.jwt, this.props.match.params.id);
        const result = JSON.parse(response.text);
        result.data.filters = this.props.filters;
        const procedureSteps =  _.filter(this.props.procedureSteps, (procedureStep) => {
            return procedureStep.id_procedure == result.data.id_procedure
        });
	    if(result.status){
           this.setState({
               procedureSteps: procedureSteps,
               isFetching: false,
               form: result.data
           })
        }else{
	        alert(response.msg)
        }
    }

    onChangeProcedures(data){
        this.setState({
            form: Object.assign({}, this.state.form, {
                id_procedure: data.id_procedure,
                id_status: data.id_status,
            }),
        })
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

    renderProcedure(){
        const { form } = this.state;
        const { procedures, procedureSteps } = this.props;
        return (
            <div className="addresses-box">
                <div className="box-header">
                    <h2 className={'box-title'}>Procedures</h2>
                </div>
                <div className="box-body">
                    <EditProcedure
                        procedures = {procedures}
                        procedureSteps={procedureSteps}
                        form={form}
                        onChangeProcedures={this.onChangeProcedures.bind(this)}
                        match={this.props.match}
                        error={this.state.errors.address}
                        value={this.state.form.address}
                    />
                </div>
            </div>
        )
    }

    render() {
        const { form, errors, isFetching } = this.state;
        const { employees, workCategories } = this.props;
        if(isFetching) return <Loading/>
        return(
                <div className="">
                    <div className="box box-primary">
                        <form>
                            <div className="box-body" >
                                <Input onChangeValue={this.onChangeValue.bind(this, true)} title={'Title *'} name={'title'}
                                   placeholder={'Enter title'} error={errors.title} type={'text'} value={form.title}/>

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
                                {/*</div>  */}
                                <div className={ClassNames({'form-group': true})}>
                                    <label>Leader *</label>
                                    <select name="id_leader" id="" className={'form-control'} value={form.id_leader} onChange={this.onChangeValue.bind(this)}>
                                        {employees.map((employee)=>(
                                            <option value={employee.id} key={employee.id}>{employee.name}</option>
                                        ))}
                                    </select>
                                </div>

                                <div className={ClassNames({'form-group': true})}>
                                <label>Work Categories *</label>
                                <select name="id_work_category" id="" className={'form-control'} value={form.id_work_category} onChange={this.onChangeValue.bind(this)}>
                                    {workCategories.map((workCategory)=>(
                                        <option value={workCategory.id} key={workCategory.id}>{workCategory.title}</option>
                                    ))}
                                </select>
                                </div>

                                {this.renderProcedure()}

                                <div className={ClassNames({'form-group': true})}>
                                    <label>Hard</label>
                                    <textarea
                                        className="form-control"
                                        defaultValue={form.hard}
                                        name={'hard'}
                                        onChange={this.onChangeValue.bind(this, false)}
                                    />
                                </div>
                                {/*{this.props.employee.id == form.id_leader &&*/}
                                    {/*<div className={ClassNames({'form-group': true})}>*/}
                                        {/*<label>Suggesstion</label>*/}
                                        {/*<textarea */}
                                            {/*className="form-control"    */}
                                            {/*defaultValue={form.leader_suggesstion}*/}
                                            {/*name={'leader_suggesstion'}*/}
                                            {/*onChange={this.onChangeValue.bind(this, false)} */}
                                        {/*/>*/}
                                    {/*</div>*/}
                                {/*}*/}
                               
                                {/*<div className={ClassNames({'form-group': true})}>*/}
                                    {/*<label>Need change</label>*/}
                                    {/*<textarea */}
                                        {/*className="form-control"    */}
                                        {/*defaultValue={form.need_change}*/}
                                        {/*onChange={this.onChangeValue.bind(this, false)} */}
                                    {/*/>*/}
                                {/*</div> */}
                            </div>

                            <div className="box-footer">
                                <button type="button" onClick={() => this.props.history.push('/work-profile')} className="btn btn-default">Back</button>
                                <button type="button" onClick={this.onSubmitInfomation.bind(this)} className="btn btn-info pull-right">Save</button>
                            </div>
                        </form>
                    </div>
                </div>
        )
    }
}
