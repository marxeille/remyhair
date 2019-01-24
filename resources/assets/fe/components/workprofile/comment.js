import React, {Component, PureComponent} from 'react';
import _ from 'lodash';
import Api from '../../api';

export default class Comment extends Component{
    constructor(props){
        super(props);
        this.state = {
            comments: !_.isEmpty(props.detail.comment) ? props.detail.comment : []
        };
        this.sendComment = this.sendComment.bind(this);
        this.handleKeyPress = this.handleKeyPress.bind(this);
        this.archive = this.archive.bind(this);
    }

     async sendComment(){
        if(!_.isEmpty(this.comment)){
           await Api.sendWorkProfileComment(this.props.jwt, this.props.detail.id, this.props.employee.id, this.comment.value)
            this.setState({
                 comments: _.concat(this.state.comments, {
                     employee:{
                         name:this.props.employee.name
                     } ,
                     comment: this.comment.value,
                 }),
                 comment: ''
             });
        }
    }

    handleKeyPress(event){
        if(event.key === 'Enter'){
            this.sendComment();
        }
    }

    archive(){
        if(confirm('Archive?')){
            this.props.archive();
        }
    }

    render(){
        const {employee, detail} = this.props;
        const {comments} = this.state;
        return (
            <div className="kanban-popup">
                <button className="btn-close-popup" onClick={() => this.props.close()}></button>
                {employee.id == detail.id_leader || employee.id_group == 1 ||  employee.id == detail.id_employee ?
                    <div>
                        <div className="title-popup"><h3 className="title-form">Detail</h3></div>
                        <p>{detail.employee.name}</p>
                        <label htmlFor="desc">Description:</label>
                        <p>{detail.hard ? detail.hard : 'Không có khó khăn' }</p>
                        <div className={'comments'}>
                            {comments.map((comment, index) => (
                                <CommentDetail key={index} comment={comment} />
                            ))}
                        </div>
                        <label htmlFor="desc">Comment:</label>
                        <textarea id="desc" name={'comment'}
                                  ref={(ref) => this.comment = ref}
                                  onChange={(event) => this.setState({comment: event.target.value})}
                                  value={this.state.comment}
                                  rows="5">

                        </textarea>
                        <div className="btn-view-popup">
                            <button className="save-button" onClick={this.archive}>Archive</button>
                            <button className="save-button" onClick={this.sendComment}>Send</button>
                        </div>
                    </div>
                    :
                     null
                }
            </div>
        )
    }
}

class CommentDetail extends PureComponent{
    render(){
        return(
            <div>
                <label htmlFor="sender">{this.props.comment.employee.name} :</label>
                <span>{this.props.comment.comment}</span>
            </div>
        )
    }
}
