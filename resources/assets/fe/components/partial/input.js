import React, { Component } from 'react'
import ClassNames from "classnames";

export default class Input extends Component{
    constructor(props){
        super(props);
        this.state = {
            error: this.props.error,
            value: this.props.value,
            title: this.props.title,
            name: this.props.name,
            placeholder: this.props.placeholder,
        }
    }

    componentWillReceiveProps(props){
        this.setState({error: props.error, value: props.value})
    }

    render(){
        return (
            <div className={ClassNames({'form-group': true}, {'has-error': this.state.error})}>
                <label>{this.state.title}</label>
                <input type={this.props.type} className="form-control"  value={this.state.value} name={this.state.name} placeholder={this.state.placeholder} onBlur={this.props.onblur ? this.props.onblur.bind(this) : null} onChange={this.props.onChangeValue.bind(this)} />
                <span className={ClassNames({'help-block': true},{'hidden': !this.state.error})}>{this.state.error}</span>
            </div>
        )
    }

}
