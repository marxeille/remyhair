import React, { Component } from 'react'
import Loading  from '../layout/loading'
import Api from '../../api'
import * as _ from 'lodash'
import Input from "../partial/input";
import { receiveNewEmployee, requestEmployee, requestGetList} from "../../actions/employee";
import ClassNames from "classnames";
import {config} from "../../constant";
import DatePicker from 'react-datepicker'
import moment from 'frozen-moment';
import 'react-datepicker/dist/react-datepicker.css';

export default class EditEmployee extends Component{
	constructor(props) {
        super(props);
        const date = moment();
        this.state = {
            isFetching: true,
            groups: this.props.groups,
            errors: [],
            title: '',
            isInited: false,
            employee: this.props.employee,
        };
        this.errorMsg = 'Field is required';
        this.onChangeDate = this.onChangeDate.bind(this)
        this.onSubmit = this.onSubmit.bind(this)
        this.onChangeValue = this.onChangeValue.bind(this)
    }

    componentWillMount(){
        this.props.dispatch(requestEmployee(this.props.jwt, this.props.match.params.id));
    }

    componentWillReceiveProps(nextProps){
        if(!_.isEmpty(nextProps.employee)){
            const form = nextProps.employee
            form.date_of_birth = moment(nextProps.employee.date_of_birth);
            form.join_date = moment(nextProps.employee.join_date);
            form.date_of_contract = moment(nextProps.employee.date_of_contract);
            form.date_of_graduation = moment(nextProps.employee.date_of_graduation);
            this.setState({
                employee: form,
            })
        }
    }

    componentDidUpdate(){
	    const { employee, isFetching, isInited} = this.state
        if(!_.isEmpty(employee) && isFetching && !isInited ){
	        this.setState({
                isFetching: false,
                isInited: true,
            })
        }
    }

    async onSubmit(){
	    const { employee } = this.state;
	    const data = _.clone(employee);
	    const dataToFetch = _.clone(employee);
        const errors = {
            id_group: !employee.id_group ? this.errorMsg : '',
            address: !employee.address ? this.errorMsg : '',
            email: !employee.email ? this.errorMsg : '',
            phone: !employee.phone ? this.errorMsg : '',
            name: !employee.name ? this.errorMsg : '',
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
            employee.date_of_birth = dataToFetch.date_of_birth.format('YYYY-MM-DD');
            employee.join_date = dataToFetch.join_date.format('YYYY-MM-DD');
            employee.date_of_contract = dataToFetch.date_of_contract.format('YYYY-MM-DD');
            employee.date_of_graduation = dataToFetch.date_of_graduation.format('YYYY-MM-DD');
            employee.filters = this.props.filters;
            employee.page_number = this.props.page_number;
            Api.editEmployee(this.props.jwt, employee).then((response) => {
                const result = JSON.parse(response.text);
                if(result.status){
                    if(!_.isEmpty(this.props.employees)){
                        const employees = this.props.employees.map((employee) => {
                            if(employee.id == result.data.employee.id){
                                return result.data.employee
                            }else return employee
                        })
                        this.props.dispatch(receiveNewEmployee(employees));
                    }else{
                        this.props.dispatch(requestGetList(this.props.jwt));
                    }
                    this.props.history.push('/employee')
                }else{
                    this.setState({
                        isFetching: false,
                        errors: result.data,
                        employee: data
                    });
                }
            }).catch((errors)=>{
                alert(errors.message())
            })


        }
    }

    onChangeValue(require, event){
	    const state = {
            employee: Object.assign({}, this.state.employee, {
                [event.target.name]: event.target.value
            })
        };
	    if(require){
	        if(event.target.name == 'email'){
                state.errors = Object.assign({}, this.state.errors, {
                    [event.target.name]: (!event.target.value || !event.target.value.match(config.emailMatch) ) ? this.errorMsg : ''
                })
            }
            else if(event.target.name == 'phone'){
                state.errors = Object.assign({}, this.state.errors, {
                    [event.target.name]: (!event.target.value || !event.target.value.match(config.phoneMatch) ) ? this.errorMsg : ''
                })
            }else{
                state.errors = Object.assign({}, this.state.errors, {
                    [event.target.name]: (!event.target.value) ? this.errorMsg : ''
                })
            }
        }
            this.setState(state);

    }

    onChangeDate(field, date) {
        this.setState({
            employee: Object.assign({}, this.state.employee, {
                [field]: date.format('YYYY-MM-DD 23:59:59')
            })
        });
    }

    render(){
	    const { errors , employee, isFetching, groups } = this.state;
        if(isFetching) return <Loading/>
        return(
            <div className="">
                {isFetching ?  <Loading/> :
                    <div className="box box-primary box-edit-employee">
                        <div className="box-header text-center">
                            <h4>Edit Employee</h4>
                        </div>
                        <form>
                            <div className="box-body" >
                                <Input onChangeValue={this.onChangeValue.bind(this, true)} title={'Name *'} name={'name'}
                                       placeholder={'Enter name'} error={errors.name} type={'text'} value={employee.name}/>
                                <Input onChangeValue={this.onChangeValue.bind(this, true)} title={'Email *'} name={'email'}
                                       placeholder={'Enter email'} error={errors.email} type={'email'} value={employee.email} />
                                <Input onChangeValue={this.onChangeValue.bind(this, true)} title={'Phone *'} name={'phone'}
                                       placeholder={'Enter phone'} error={errors.phone} type={'text'} value={employee.phone}
                                />
                                <Input onChangeValue={this.onChangeValue.bind(this, false)} title={'Password *'} name={'password'}
                                       placeholder={'Enter password'} error={errors.password} type={'password'} value={employee.password}
                                />
                                <div className={ClassNames({'form-group': true}, {'has-error': errors.id_group})}>
                                    <label>Group</label>
                                    <select name="id_group" className={'form-control'} defaultValue={employee.id_group} onChange={this.onChangeValue.bind(this, true)}>
                                        <option value="">--</option>
                                        {groups.map((group) => (
                                            <option value={group.id} key={group.id} >{group.name}</option>
                                        ))}
                                    </select>
                                    <span className={ClassNames({'help-block': true},{'hidden': !errors.id_group})}>{errors.id_group}</span>
                                </div>
                                <div className={'group-date'}>
                                    <div className={'form-group'}>
                                        <label>Date of birth</label>
                                        <br/>
                                        <DatePicker
                                            showYearDropdown
                                            selected={employee.date_of_birth}
                                            onChange={this.onChangeDate.bind(this, 'date_of_birth')}
                                            className="form-control"
                                        />
                                    </div>
                                    <div className={'form-group'}>
                                        <label>Join date</label>
                                        <br/>
                                        <DatePicker
                                            showYearDropdown
                                            selected={employee.join_date}
                                            onChange={this.onChangeDate.bind(this, 'join_date')}
                                            className="form-control"
                                            dateFormat="DD/MM/YYYY"
                                        />
                                    </div>
                                    <div className={'form-group'}>
                                        <label>Date of constract</label>
                                        <br/>
                                        <DatePicker
                                            showYearDropdown
                                            selected={employee.date_of_contract}
                                            onChange={this.onChangeDate.bind(this, 'date_of_contract')}
                                            className="form-control"
                                            dateFormat="DD/MM/YYYY"
                                        />
                                    </div>
                                </div>
                                <Input onChangeValue={this.onChangeValue.bind(this, true)} title={'Address *'} name={'address'}
                                       placeholder={'Enter address'} error={errors.address} type={'text'} value={employee.address}
                                />
                                <Input onChangeValue={this.onChangeValue.bind(this, false)} title={'Facebook '} name={'facebook'}
                                       placeholder={'Enter facebook'} type={'text'} value={employee.facebook}
                                />
                                <div className={'group-inform'}>
                                    <Input onChangeValue={this.onChangeValue.bind(this, false)} title={'Education '} name={'education'}
                                           placeholder={'Enter education'}  type={'text'} value={employee.education}
                                    />
                                    <Input onChangeValue={this.onChangeValue.bind(this, false)} title={'School'} name={'school'}
                                           placeholder={'Enter school'}  type={'text'} value={employee.school}
                                    />
                                    <Input onChangeValue={this.onChangeValue.bind(this, false)} title={'Major'} name={'major'}
                                           placeholder={'Enter major'} type={'text'} value={employee.major}
                                    />
                                    <div className={'form-group date-gradua'}>
                                        <label>Date of graduation</label>
                                        <br/>
                                        <DatePicker
                                            showYearDropdown
                                            selected={employee.date_of_graduation}
                                            onChange={this.onChangeDate.bind(this, 'date_of_graduation')}
                                            className="form-control"
                                            dateFormat="DD/MM/YYYY"
                                        />
                                    </div>
                                </div>
                                <div className="box-footer">
                                    <button type="button" onClick={() => this.props.history.push('/employee')} className="btn btn-default">Back</button>
                                    <button type="button" onClick={this.onSubmit.bind(this)} className="btn btn-info pull-right">Save</button>
                                </div>
                            </div>
                        </form>
                    </div>
                }

            </div>
        )
    }
}

