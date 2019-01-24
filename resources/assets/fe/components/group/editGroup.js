import React, { Component } from 'react'
import Loading  from '../layout/loading'
import ClassNames from 'classnames'
import {addGroup} from "../../actions/group";
import Api from '../../api'

export default class EditGroup extends Component{
	constructor(props) {
        super(props);
        this.state = {
            isFetching: true,
            permissions: this.props.permissions,
            errors: '',
            title: '',
            check_all: false
        };
    }

    componentWillMount(){
        Api.getGroup(this.props.jwt, this.props.match.params.id).then((reponse) => {
            const result = JSON.parse(reponse.text);
            result.data.permission = this.props.permissions.map((permission) => {
                return Object.assign(permission, {
                    isSelected: !_.isEmpty(_.filter(result.data.permission, (p)=>{
                        return p.action == permission.name
                    }))
                });
            });
            this.setState({
                group: result.data,
                permissions:  result.data.permission,
                title: result.data.name,
                isFetching: false
            });
        }).catch((err) => {
            alert(err)
        });
    }

    componentWillReceiveProps(props){
	    if(props){
	        this.setState({
                permissions: props.permissions,
            });
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

    onSelectAll(event) {
        let permissions;
        permissions = this.state.permissions.map((permission) => {
            return Object.assign(permission, {
                isSelected: !this.state.check_all
            })
        });
        this.setState({
            permisions: permissions,
            check_all: !this.state.check_all
        })
    }

   async onSubmit(){
        if(!this.state.errors){
            const result = await Api.editGroup(this.props.jwt, this.state.group.id, {
                name: this.state.title,
                permissions: _.filter(this.state.permissions, (permission) => {
                    return permission.isSelected
                })
            });
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
            })
        }

    }

    render(){
	    if(this.state.isFetching){
	        return <Loading/>
        }
        if(!this.state.group){
	        return <div>Group could not be found</div>
        }



        return(
            <div className="editGroupContent">
                <div className="box box-primary">
                    <div className="box-header text-center">
                        <h4>Edit Group</h4>
                    </div>
                    <form className="form-horizontal">
                        <div className="box-body" >
                            <input type="text" className="form-control" placeholder={"Title"} onChange={this.onChangeTitle.bind(this)} value={this.state.title} />
                            <br/>
                            <span className={ClassNames({'hidden' : !this.state.errors})}>{this.state.errors}</span>
                            <div>
                                <div>

                            <div className="select_all">
                            <input type="checkbox" checked={this.state.check_all} name={ this.state.check_all == false ? 'Select all' : 'Unselect all'} onChange={this.onSelectAll.bind(this)} />
                            <span>{'Select all'}</span>
                            </div>

                                <div>
                                    <h3>Permissions</h3>
                                </div>
                                </div>
                                <div>
                                {this.state.permissions && this.state.permissions.map((permission, i) => (
                                    <div key={i} className="custom-row">
                                        <input type="checkbox" checked={permission.isSelected} name={permission.name} onChange={this.addChangePermission.bind(this)} />
                                        <p>{permission.name}</p>
                                    </div>
                                ))}
                                </div>
                            </div>
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

