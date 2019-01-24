import React, { Component } from 'react';
import Input from "../partial/input";
import EditProcedureStep from "../../containers/workprofile/editProcedureStep";
import Loading from "../layout/loading";
import Api from '../../api'
import {receiveProcedures, requestGetProcedures} from "../../actions/workprofile";
import * as _ from 'lodash'

export default class EditProcedureForkanban extends Component{
    constructor(props){
        super(props);
        this.state = {
            form: {},
            errors:{},
            loading: true
        }

        this.removeProcedure = this.removeProcedure.bind(this);
    }

   async componentWillMount(){
        try{
            const fetch = await Api.getProcedure(this.props.jwt, this.props.match.params.id);
            const result = JSON.parse(fetch.text);
            if(result.status){
                this.setState({
                    form: result.data,
                    loading: false,
                })
            }else{
                alert(result.msg);``
                this.setState({
                    loading: false,
                })
            }
        }catch(errors){
            alert(errors.message)
        }
    }

    onChangeValue(event){
        this.setState({
            form: Object.assign({}, this.state.form, {
                [event.target.name]: event.target.value
            }),
            errors: Object.assign({}, this.state.errors, {
                [event.target.name]: (!event.target.value) ? true : false
            })
        });
    }

    updateSteps(steps){
        this.setState({
            form: Object.assign({}, this.state.form, {
                procedure_steps: steps
            })
        })
    }

    async removeProcedure(){
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
        const { form } = this.state;

        if(_.size(_.filter(form.steps, (step) => {
            return !step.name;
        })) == 0 && form.title){
            this.setState({
                loading: true
            });
            try{
                const fetch = await Api.editProcedure(this.state.form);
                const result = JSON.parse(fetch.text);
                if(result.status){
                    if(!_.isEmpty(this.props.procedures)){
                        const procedures = this.props.procedures.map((procedure) => {
                            if(procedure.id == result.data.id){
                                return result.data
                            }else return procedure
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
    }

    render(){
        const { loading, form } = this.state;
        return(
            <div className="editProcedureContent">
                {loading ? <Loading/> : _.isEmpty(form) ? <h4>Not found procedure</h4> : <div className="box box-primary">
                    <div className="box-header text-center">
                        <h4>Edit Procedure</h4>
                    </div>
                    <div className="box-body" >
                        <Input onChangeValue={this.onChangeValue.bind(this)} title={'Procedure: *'} name={'title'}
                               placeholder={'Enter procedure name'} error={this.state.errors.title} type={'text'} value={form.title}/>
                        <EditProcedureStep steps={form.procedure_steps}  jwt={this.props.jwt} updateSteps={this.updateSteps.bind(this)}/>
                    </div>
                    <div className="box-footer">
                        <button type="button" onClick={() => this.props.history.push('/procedure')} className="btn btn-default">Back</button>
                        <button 
                            type="button" 
                            onClick={() => {
                                if(confirm('Are you sure?')){
                                    this.removeProcedure
                                }
                            }} 
                            className="btn btn-default btn-danger btn-remove"
                        >
                            Remove
                        </button>
                        <button type="button" onClick={this.onSubmit.bind(this)} className="btn btn-info pull-right">Save</button>
                    </div>
                </div> }

            </div>
        )
    }
}
