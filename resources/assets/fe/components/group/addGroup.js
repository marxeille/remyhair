import React, { Component } from 'react'
import Loading  from '../layout/loading'
import ClassNames from 'classnames'
import {addGroup} from "../../actions/group";
import Api from '../../api'

export default class AddGroup extends Component{
	constructor(props) {
        super(props);
        this.state = {
            permissions: this.props.permissions.map((permission) => {
                return Object.assign(permission, {
                    isSelected: false
                })
            }),
            errors: '',
            title: ''
        };
    }

    componentWillReceiveProps(props) {
        if (props) {
            this.setState({
                permissions: props.map((permission) => {
                    return Object.assign(permission, {
                        isSelected: false
                    });
                })
            })
        }
    }

    addChangePermission(event){
	    let permissions;
	    if(event.target.name == 'all'){
             permissions = this.state.permissions.map((permission) => {
                return Object.assign(permission, {
                    isSelected: !permission.isSelected
                })
            });
        }else{
             permissions = this.state.permissions.map((permission) => {
                return Object.assign(permission, {
                    isSelected: (event.target.name == permission.name) ? !permission.isSelected : permission.isSelected
                })
            });
        }
        this.setState({
            permisions: permissions
        })
    }

   async onSubmit(){
        if(!this.state.errors){
            const result = await Api.addGroup(this.props.jwt, {
                name: this.state.title,
                permissions: _.filter(this.state.permissions, (permission) => {
                    return permission.isSelected
                })
            })
            const response = JSON.parse(result.text);

            if(!response.status){
                this.setState({errors: response.data.name})
           }else{
                this.props.history.push('/group');
           }
        }
    }

    onChangeTitle(event){
        if(!event.target.value){
            this.setState({errors: 'Title field id required'});
        } else{
            this.setState({
                title: event.target.value,
                errors: ''
            })
        }
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
                            <span className={ClassNames({'hidden' : !this.state.errors}, {'help-block': true})}>{this.state.errors}</span>
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

