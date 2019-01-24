import React, {Component} from 'react';
import _ from 'lodash';
import Api from "../../../api";

export default class WorkProfileDescription extends Component{
    constructor(props){
        super(props);
        this.state = {
            workProfile: props.workProfile,
            showEditDesc: false
        };
        this.originalDesc = props.workProfile.hard;
        this.saveDesc = this.saveDesc.bind(this);
    }

    shouldComponentUpdate(nextProps, nextState){
        return !_.isEqual(nextState, this.state);
    }

    async saveDesc(){
        this.setState({
            showEditDesc: false
        });
        await Api.editWorkProfile(this.props.jwt, {
            ...this.state.workProfile
        });
    }

    render(){
        const {workProfile, showEditDesc} = this.state;
        return(
            <div>
                <label htmlFor="desc">Description:</label> <button onClick={() => this.setState({showEditDesc: true})}>Edit</button>
                {showEditDesc ?
                    <div>
                                         <textarea id="desc" name={'desc'}
                                                   ref={(ref) => this.desc = ref}
                                                   onChange={(event) => this.setState({
                                                       workProfile: Object.assign({}, this.state.workProfile, {
                                                           hard: event.target.value
                                                       }),
                                                   })}
                                                   value={workProfile .hard}
                                                   rows="5">
                                         </textarea>
                        <button onClick={this.saveDesc}>Save</button>
                        <button onClick={() => this.setState(
                            {
                                showEditDesc: false,
                                workProfile: Object.assign({}, this.state.workProfile, {
                                    hard: this.originalDesc
                                }),
                                })}>X</button>
                    </div>
                    :
                    <p>{workProfile.hard}</p>
                }
            </div>

        )
    }
}
