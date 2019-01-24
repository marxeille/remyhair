import React, { Component, Fragment } from 'react'
import { Link } from 'react-router-dom'
import Api from '../../api'
import * as _ from 'lodash'

export default class DetailCustomer extends Component{
    constructor(props) {
        super(props);
        this.state = {
            isFetching: true,
            customer: null,
        }
    };

    async componentWillMount(){
	    const response = await Api.detailCustomer(this.props.jwt, this.props.match.params.id);
	    const result = JSON.parse(response.text);
	    result.data.filters = this.props.filters;
	    if(result.status){
           this.setState({
               isFetching: false,
               customer: result.data
           })
        }else{
	        alert(response.msg)
        }
    }

    render(){
        const { customer } = this.state;
        return(
            <Fragment>
                {
                    customer ?
                    <div className="box box-primary">
                        <div className="box-header with-border text-center">
                            <h3 className="">Customer</h3>
                        </div>
                        <div className="box-body">
                            <p>Full name: {customer.customer.full_name ? customer.customer.full_name : ''}</p>
                            <p>Email: {customer.customer.email ? customer.customer.email : ''}</p>
                            <p>Phone: {customer.customer.phone ? customer.customer.phone : ''}</p>
                            <p>Type: {customer.customer.type ? customer.customer.type : ''}</p>
                            <p>Special Customer: {customer.customer.is_special_customer == 1 ? 'Special' : 'None special'}</p>
                            <p>Status: {customer.customer.status}</p>
                            <p>Created at: {customer.customer.created_at}</p>
                            <p>Employee: {customer.customer.employee.name}</p>
                        </div>
                        <div className="box-footer">
                            <button type="button" onClick={() => this.props.history.push('/customer')} className="btn btn-default">Back</button>
                            <button type="button" className="btn btn-info pull-right">
                                <Link to={'/customer/edit/'+customer.customer.id}>
                                    <i className={'fa fa-edit'}></i>
                                </Link>
                            </button>
                        </div>
                        
                    </div>
                    : 
                    null
                }
                
            </Fragment>
        );
    }
}
