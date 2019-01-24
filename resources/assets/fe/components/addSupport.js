import React, { Component } from 'react'
import Loading  from './layout/loading'
import ClassNames from 'classnames'
import {addGroup} from "../actions/group";
import Api from '../api'

export default class AddSupport extends Component{
	constructor(props) {
        super(props);
        this.state = {
            errors: '',
        };
    }

    render(){
        return(
            <div className="col-md-6 col-xs-12 col-offset-md-3">
                <div className="box box-primary">
                    <div className="box-header text-center">
                        <h4>Add Group</h4>
                    </div>
                    <form className="form-horizontal">
                        <div className="box-body" >
                            <input type="text" className="form-control" placeholder={"Title"} onChange={this.onChangeTitle.bind(this)} />
                            <br/>
                            <span className={ClassNames({'hidden' : !this.state.errors})}>{this.state.errors}</span>
                            <table className="table table-hover">
                                <thead>
                                <tr>
                                    <th>Permissions</th>
                                </tr>
                                </thead>
                                <tbody>
                                {this.state.permissions && this.state.permissions.map((permission, i) => (
                                    <tr key={i}>
                                        <th scope="row">
                                            <input type="checkbox" checked={permission.isSelected} name={permission.name} onChange={this.addChangePermission.bind(this)} />
                                        </th>
                                        <td>{permission.name}</td>
                                    </tr>
                                ))}
                                </tbody>
                            </table>
                        </div>
                        <div className="box-footer">
                            <button type="button" onClick={() => this.props.history.push('/group')} className="btn btn-default">Back</button>
                            <button type="button" onClick={this.onSubmit.bind(this)} className="btn btn-info pull-right">Save</button>
                        </div>
                    </form>
                </div>
            </div>
        )
    }
}

