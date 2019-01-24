import React, { Component } from 'react'
import Loading  from '../layout/loading'
import ClassNames from 'classnames'
import Api from '../../api'
import * as _ from 'lodash'
import {receiveAddSupport, requestGetList} from "../../actions/support";
export default class AddEmployeeFamily extends Component{
    constructor(props) {
        super(props);
        this.state = {
            isFetching: false,
            errors: [],
            form: {
                id_employee: null,
                name: null,
                current_job: null,
                relation: null,
            },
        }
        this.errorMsg = 'Customer is required';
    }

    async onSubmit(){
        const {errors} = this.state;
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
               const fetch = await Api.addEmployeeFamily(this.state.form, this.props.match.params.id);
               const result = JSON.parse(fetch.text);
               if(result.status){
                   this.props.history.push('/employee')
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

    onChangeValue(event){
        this.setState({
            form: Object.assign({}, this.state.form, {
                [event.target.name]: event.target.value
            }),
            errors: Object.assign({}, this.state.errors, {
                [event.target.name]: ''
            })
        });
    }
    
    render(){
        const {errors, form} = this.state;
        return(
            <div className="box box-primary">
                <div className="box-header with-border text-center">
                    <h1 className="box-title">Employee Family</h1>
                </div>
                <form className="form-horizontal">
                    <div className={ClassNames({'required-txt': true}, {'has-error': errors.customer})}>
                        <span className={ClassNames({'help-block': true},{'hidden': !errors})}>{errors.customer}</span>
                    </div>
                   
                    <div className={ClassNames({'box-body': true}, {'has-error': errors.name})}>
                        <label>Name</label>
                        <input name="name"  onChange={this.onChangeValue.bind(this)} className="form-control" type="text" placeholder="Name" value={this.state.form.name}/>
                        <span className={ClassNames({'help-block': true},{'hidden': !errors})}>{errors.name}</span>
                    </div>

                    <div className={ClassNames({'box-body': true}, {'has-error': errors.support_time})}>
                        <label>Current job</label>
                        <input name="current_job"  onChange={this.onChangeValue.bind(this)} className="form-control" type="text" placeholder="Current job" value={this.state.form.current_job}/>
                        <span className={ClassNames({'help-block': true},{'hidden': !errors})}>{errors.support_time}</span>
                    </div>

                    <div className={ClassNames({'box-body': true}, {'has-error': errors.support_time})}>
                        <label>Relation</label>
                        <input name="relation"  onChange={this.onChangeValue.bind(this)} className="form-control" type="text" placeholder="Relation" value={this.state.form.relation}/>
                        <span className={ClassNames({'help-block': true},{'hidden': !errors})}>{errors.support_time}</span>
                    </div>
                   
                    <div className="box-footer">
                        <button type="button" onClick={() => this.props.history.push('/employee')} className="btn btn-default">Back</button>
                        <button type="button" onClick={this.onSubmit.bind(this)} className="btn btn-info pull-right">Save</button>
                    </div>
                </form>
            </div>
        )
    }
}
