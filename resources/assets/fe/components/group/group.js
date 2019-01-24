import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import ClassNames from 'classnames'
import {hasRole} from "../../utility";
import Loading from "../layout/loading";
import Api from '../../api'
import {getAll} from "../../actions/group";

export default class Group extends Component{
	constructor(props) {
        super(props);
        this.state = {
        	edit: false,
        	add:false,
            isFetching: true,
            groups: this.props.groups,
            group: this.props.group,
            permissions: this.props.permissions,
            actions: this.props.actions,
        };
    }

   componentWillMount(){
        this.setState({
            isFetching: true
        })
       this.props.dispatch(getAll(this.props.jwt));
   }

   removeGroup(id){
        if(confirm('Are you sure?')){
            this.setState({
                isFetching: true
            });
            Api.removeGroup(this.props.jwt, id).then((reponse) => {
                const result = JSON.parse(reponse.text);
                this.getGroups();
            }).catch((err) => {
                alert(err)
            });
        }
   }

    componentWillReceiveProps(nextProps){
	    if(!_.isEmpty(nextProps.groups)){
	        this.setState({
                isFetching: false,
                groups: nextProps.groups
            })
        }
   }

    render(){
	    if(this.state.isFetching){
	        return <Loading/>
        }

        return(
            <div className="">
	            <div className="box box-primary">
                    <div className="box-header  text-center">
                        <h2 className="box-title">Group</h2>
                    </div>
					<div className="box-body">
						<div className="table-responsive">
							<table className="table table-hover">
								<thead>
									<tr>
										<th scope="col" className="col-md-9">Name</th>
										<th scope="col" className="col-md-2">Action</th>
									</tr>
								</thead>
								<tbody>
                                {this.state.groups.map((group) => (
                                    <tr key={group.id}>
                                        <td>{group.name}</td>
                                        <td>
                                            <Link  to={'/group/edit/' + group.id} className="btn btn-flat">
                                                <i className={'fa fa-edit'}></i>
                                            </Link>
                                        </td>
                                    </tr>
                                ))}
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
        )
    }
}
class EditGroup extends Component{
	render(){
        return(
        	<div className="col-md-6">
					<div className="box box-primary">
						<div className="box-header text-center">
							<h4>Edit Group</h4>
						</div>
						<form className="form-horizontal">
							<div className="box-body">
								<table className="table table-hover">
									<tbody>
										<tr>
											<th scope="row"><input type="checkbox" /></th>
											<td>Mark</td>
										</tr>
										<tr>
											<th scope="row"><input type="checkbox" /></th>
											<td>Mark le</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div className="box-footer">
				                <button type="submit" className="btn btn-default">Delete</button>
				                <button type="submit" className="btn btn-info pull-right">Save</button>
				            </div>
						</form>
					</div>
				</div>

        )
    }
}

