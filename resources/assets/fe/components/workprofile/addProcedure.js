import React, { Component } from 'react';
import Input from "../partial/input";
import ClassNames from "classnames";
import AddAddress from "../customer/addAddress";
import AddProcedureStep from "../../containers/workprofile/addProcedureStep";
import Loading from "../layout/loading";
import Api from '../../api'
import {receiveProcedures, requestGetProcedures} from "../../actions/workprofile";

export default class AddProcedure extends Component{
    constructor(props){
        super(props);
        this.state = {
            form: {
                steps: [
                    {
                        id:1,
                        name: '',
                        number: '',
                    }
                ]
            },
            errors:{}
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
                steps: steps
            })
        })
    }

    async onSubmit(){
        const { form } = this.state;
        if(_.size(_.filter(form.steps, (step) => {
            return !step.name;
        })) == 0 && form.name){
            this.setState({
                loading: true
            });
            try{
                const fetch = await Api.addProcedure(this.state.form);
                const result = JSON.parse(fetch.text);
                if(result.status){
                    if(!_.isEmpty(this.props.procedures)){
                        const procedures = _.concat(this.props.procedures, result.data);
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
        const { loading } = this.state
        return(
            <div className="">
                {loading ? <Loading/> : <div className="box box-primary">
                    <div className="box-header text-center">
                        <h4>Add Procedure</h4>
                    </div>
                    <div className="box-body" >
                        <Input onChangeValue={this.onChangeValue.bind(this)} title={'Procedure: *'} name={'name'}
                               placeholder={'Enter procedure name'} error={this.state.errors.name} type={'text'} value={this.state.form.name}/>
                        <AddProcedureStep steps={this.state.form.steps}  updateSteps={this.updateSteps.bind(this)}/>
                    </div>
                    <div className="box-footer">
                        <button type="button" onClick={() => this.props.history.push('/procedure')} className="btn btn-default">Back</button>
                        <button type="button" onClick={this.onSubmit.bind(this)} className="btn btn-info pull-right">Save</button>
                    </div>
                </div> }

            </div>
        )
    }
}
