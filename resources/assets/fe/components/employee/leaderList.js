import React, { Component } from 'react'

export default class LeaderList extends Component{
    constructor(props){
        super(props);
        this.state = {
            leaders: this.props.leaders,
            selected: this.props.selected
        }
    }

    componentWillReceiveProps(nextProps){
        if(nextProps.leader != this.props.leaders || nextProps.selected != thiss.props.selected){
            this.setState({
                leaders: nextProps.leaders,
                selected: nextProps.selected
            })
        }
    }

    render(){
        return (
            <select name="id_leader" className={'form-control'} defaultValue={this.props.defaultValue} onChange={this.props.onChange.bind(this)}>
                <option value="" >--</option>
                {this.state.leaders.map((leader) => (
                    <option value={leader.id} key={leader.id} defaultChecked={this.state.selected == leader.id}>{leader.name}</option>
                ))}
            </select>
        )
    }
}
