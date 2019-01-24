import React, { Component } from 'react'
import * as _ from 'lodash'
import {requestGetProcedures} from "../../actions/workprofile";
import { Link } from 'react-router-dom'
import Loading from "../layout/loading";

export default class Procedure extends Component{
    constructor(props){
        super(props);
        this.state = {
            procedures: this.props.procedures
        }
    }

    componentWillMount(){
        if(_.isEmpty(this.state.procedures)){
            this.setState({
                loading: true
            });
            this.props.dispatch(requestGetProcedures());
        }
    }

    componentWillReceiveProps(props){
        this.setState({
            procedures: props.procedures,
            loading: false
        })
    }

    render(){
        const { loading, procedures } = this.state;
        if(loading) return <Loading/>;
        return(
            <div className="procedure-container">
                <Link to={'/procedure/add'} className="btn-add">Add</Link>
                {_.isEmpty(procedures) ? <div><h2>Empty</h2></div> :
                    <div>
                        <h3>List procedure</h3>
                        {procedures.map((procedure) => (
                            <div className="procedure-item">
                                <Link to={`/procedure/${procedure.id}`}>{procedure.title}</Link>
                            </div>
                        ))}
                    </div>
                }
            </div>
        )
    }
}
