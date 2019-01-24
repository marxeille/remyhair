import React, { Component, Fragment } from 'react'
import Loading  from '../layout/loading'
import ClassNames from 'classnames'
import Api from '../../api'
import moment from 'moment'

export default class DetailSupport extends Component{
    constructor(props) {
        super(props);
        this.state = {
            isFetching: true,
            support: null,
        }
    };

    async componentWillMount(){
	    const response = await Api.detailSupport(this.props.jwt, this.props.match.params.id);
	    const result = JSON.parse(response.text);
	    result.data.filters = this.props.filters;
	    if(result.status){
           this.setState({
               isFetching: false,
               support: result.data
           })
        }else{
	        alert(response.msg)
        }
    }

    render(){
        const { support } = this.state;
        return(
            <Fragment>
                {
                    support ?
                    <div className="box box-primary">
                        <div className="box-header with-border text-center">
                            <h3 className="">Support</h3>
                        </div>
                        <div className="box-body">
                            <p>Employee: {support.support.employee.name ? support.support.employee.name : '' }</p>
                            <p>Customer: {support.support.customer.full_name ? support.support.customer.full_name : '' }</p>
                            {
                                support.support.status.name
                                ?
                                <p>Invoice status: {support.support.status.name}</p>
                                :
                                null
                            }
                            {
                                support.support.updated_at
                                ?
                                <p>Support time: {moment(moment(new Date()).format('YYYY-MM-DD')).diff(moment(support.support.updated_at), 'day')}</p>
                                :
                                null
                            }
                            {
                                support.support.source
                                ?
                                <p>Source: {support.support.source }</p>
                                :
                                null
                            }
                            {
                                support.support.notes 
                                ? 
                                support.support.notes.map((note, key) =>
                                    <p>Note: {note.content}</p>
                                )
                                :
                                null 
                            }
                            {
                                support.support.complains 
                                ? 
                                support.support.complains.map((complain, key) =>
                                    <p>Complain: {complain.content}</p>
                                )
                                :
                                null 
                            }
                            {
                                support.support.created_at
                                ?
                                <p>Created day: {support.support.created_at }</p>
                                :
                                null
                            }   
                            {
                                support.support.updated_at
                                ?
                                <p>Updated day: {support.support.updated_at }</p>
                                :
                                null
                            }   
                        </div>
                        <button type="button" onClick={() => this.props.history.push('/support')} className="btn btn-default">Back</button>
                    </div>
                    : 
                    null
                }
                
            </Fragment>
        );
    }
}