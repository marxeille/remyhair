import React, { Component, Fragment } from 'react'
import Loading  from '../layout/loading'
import ClassNames from 'classnames'
import Api from '../../api'
import { Link } from 'react-router-dom'
import {hasRole} from "../../utility";

export default class DetailEmployee extends Component{
    constructor(props) {
        super(props);
        this.state = {
            isFetching: true,
            employee: null,
        }
    };

    async componentWillMount(){
	    const response = await Api.detailEmployee(this.props.jwt, this.props.match.params.id);
	    const result = JSON.parse(response.text);
	    result.data.filters = this.props.filters;
	    if(result.status){
           this.setState({
               isFetching: false,
               employee: result.data
           })
        }else{
	        alert(response.msg)
        }
    }

    render(){
        const { employee } = this.state;
        return(
            <Fragment>
                {
                    employee ?
                    <div className="box box-primary">
                        <div className="box-header with-border text-center">
                            <h3 className="">Employee</h3>
                        </div>
                        <div className={ClassNames({'btn-add-custom': true})}>
                            <Link to={'addfamily/'+employee.employee.id} className='btn btn-fat'>
                                <i className='fa fa-plus'></i> Add Employee family
                            </Link>
                        </div>
                        <div className="box-body">
                            {
                                employee.employee.name
                                ?
                                <p>Full Name: {employee.employee.name}</p>
                                :
                                null
                            }
                            {
                                employee.employee.email
                                ?
                                <p>Email: {employee.employee.email }</p>
                                :
                                null
                            }
                            {
                                employee.employee.phone
                                ?
                                <p>Phone: {employee.employee.phone}</p>
                                :
                                null
                            }
                            {
                                employee.employee.address
                                ?
                                <p>Address: {employee.employee.address}</p>
                                :
                                null
                            }
                            {
                                employee.employee.date_of_birth
                                ?
                                <p>Birth day: {employee.employee.date_of_birth }</p>
                                :
                                null
                            }
                            {
                                employee.employee.date_of_contract
                                ?
                                <p>Contract date: {employee.employee.date_of_contract}</p>
                                :
                                null
                            }
                            {
                                employee.employee.education
                                ?
                                <p>Education: {employee.employee.education}</p>
                                :
                                null
                            }
                            {
                                employee.employee.School
                                ?
                                <p>School: {employee.employee.School}</p>
                                :
                                null
                            }
                            {
                                employee.employee.group.name
                                ?
                                <p>Group: {employee.employee.group.name}</p>
                                :
                                null
                            }
                            <p>
                                <Link to={'/employee/customers/'+employee.employee.id} className='btn btn-fat'>
                                    List Customers
                                </Link>
                            </p>
                            <Link to={'/employee/supports/'+employee.employee.id} className='btn btn-fat'>
                                List Supports
                            </Link>
                        </div>
                    </div>
                    : 
                    null
                }
                {
                    employee ?
                    <div>
                        {
                        employee.employee_familys 
                        ?
                        <div className="box box-primary">
                            <h3>Family</h3>
                            {
                                employee.employee.employee_familys.map((family)=>(
                                    <div>
                                        {
                                            family.name 
                                            ?
                                            <p>Name: {family.name ? family.name : ''}</p>
                                            :
                                            null
                                        }
                                        {
                                            family.relation 
                                            ?
                                            <p>Relation: {family.relation ? family.relation : ''}</p>
                                            :
                                            null
                                        }
                                        {
                                            family.current_job 
                                            ?
                                            <p>Current Job: {family.current_job ? family.current_job : ''}</p>
                                            :
                                            null
                                        }
                                    </div>
                                ))
                            }
                        </div>
                        :
                        null
                        }
                            <button type="button" onClick={() => this.props.history.push('/employee')} className="btn btn-default">Back</button>
                    </div>
                    :
                    null
                }
            
            </Fragment>
        );
    }
}
