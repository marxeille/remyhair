import React, {Component, PureComponent} from 'react';
import _ from "lodash";
import Api from "../../../api";
import moment from 'moment';

export default class WorkProfileActivity extends Component{
    constructor(props){
        super(props);
        this.state = {
            activity: props.activity,
            newComment: ''
        };
        this.comment = null;
        this.sendComment = this.sendComment.bind(this);
        this.remove = this.remove.bind(this);
    }

    async sendComment(){
        if(!_.isEmpty(this.comment)){
            await Api.sendWorkProfileComment(this.props.jwt, this.props.idWorkProfile, this.props.employee.id, this.comment.value);
            this.setState({
                activity: _.concat(this.state.activity, {
                    employee:{
                        name:this.props.employee.name,
                        id: this.props.employee.id
                    } ,
                    comment: this.comment.value,
                    created_at: new moment()
                }),
                newComment: ''
            });
        }
    }

    remove(id){
        this.setState({
            activity: _.filter(this.state.activity, item => item.id != id)
        });
    }

    render(){
        const {activity, newComment} = this.state;
        return(
            <div>
                <label htmlFor="desc">Add comment:</label>
                <textarea id="desc" name={'comment'}
                          ref={(ref) => this.comment = ref}
                          onChange={(event) => this.setState({newComment: event.target.value})}
                          placeholder={'Your comment...'}
                          value={newComment}
                          rows="3">
                  </textarea>
                <button disabled={!newComment} className="save-button" onClick={this.sendComment}>Save</button>
                <label htmlFor="desc">Activity:</label>
                <div className={'comments'}>
                    {activity.map((item, index) => (
                        <ActivityDetail
                            key={index}
                            activity={item}
                            employee={this.props.employee}
                            jwt={this.props.jwt}
                            remove={this.remove}
                        />
                    ))}
                </div>
            </div>
        )
    }
}


class ActivityDetail extends Component{
    constructor(props){
        super(props);
        this.state = {
            activity: props.activity,
            isEditing: false
        };
        this.remove = this.remove.bind(this);
        this.save = this.save.bind(this);
        this.cancel = this.cancel.bind(this);
    }

    shouldComponentUpdate(nextProps, nextState){
        return !_.isEqual(this.state, nextState);
    }

    async remove(){
        if(confirm('Delete ? ')){
            await Api.removeWorkProfileComment(this.props.jwt, this.state.activity.id);
            this.props.remove(this.state.activity.id);
        }
    }

    async save(){
        await Api.updateWorkProfileComment(this.props.jwt, this.state.activity.id, this.comment.value);
        this.setState({
            isEditing: false
        })
    }

    cancel(){
        this.setState({
            activity: this.props.activity,
            isEditing: false
        })
    }

    render(){
        const {activity, isEditing} = this.state;
        return(
            <div>
                <div className="user-block">
                        <span className="username">
                        <a href="#">{activity.employee.name}</a>
                    </span>
                    <span className="description">{moment(activity.created_at).locale('vi').fromNow()}</span>
                </div>
                {isEditing ?
                    <textarea id="desc" name={'comment'}
                              ref={(ref) => this.comment = ref}
                              onChange={(event) => this.setState({activity: Object.assign({}, this.state.activity, {
                                      comment: event.target.value
                                  })})}
                              placeholder={'Your comment...'}
                              value={activity.comment}
                              rows="3">
                       </textarea>
                    :
                    <div className="user-comments"><p>{activity.comment}</p></div>
                }
                {this.props.employee.id == activity.employee.id &&
                <div className="button-container">
                    {isEditing ?
                        <div className="button-wrapper">
                            <button className={"btn-save-popup"} disabled={!activity.comment} onClick={this.save}>Save</button>
                            <button className={"btn-save-popup"} onClick={this.cancel}>Cancel</button>
                        </div>
                        :
                        <button className={"btn-save-popup"}  onClick={() => this.setState({isEditing: true})}>Edit</button>
                    }
                    <button className={"btn-save-popup"} onClick={this.remove}><i className="fa fa-times"></i></button>
                </div>
                }
            </div>
        )
    }
}
