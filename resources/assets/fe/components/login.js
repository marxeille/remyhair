import React, {Component} from 'react'
import * as _ from 'lodash'
import { isEmail } from "../models/validate"
import {loginSuccess, receiveLoginInfo, requestLogin} from "../actions/env";
import ClassNames from 'classnames'
import {call, put} from "redux-saga/effects";
import Api from "../api";

export default class Login extends Component{
    constructor(props){
        super(props);
        this.state = {
            email: '',
            password: '',
            remember: true,
            errors:{
                email:'',
                password: ''
            },
            loginError: ''
        };

        this.handleChangeEmail = this.handleChangeEmail.bind(this);
        this.handleChangePassword = this.handleChangePassword.bind(this);
        this.handleChangeRemember = this.handleChangeRemember.bind(this);
        this.onRequestLogin = this.onRequestLogin.bind(this);
        this.handleKeyPress = this.handleKeyPress.bind(this);
    }

    handleChangeEmail(event) {
        this.setState({email: event.target.value});
    }

    handleChangePassword(event) {
        this.setState({password: event.target.value});
    }

    handleChangeRemember() {
        this.setState({remember: !this.state.remember});
    }

    componentWillMount(){
        const authInfo = JSON.parse(localStorage.getItem('auth'));
        if(authInfo && authInfo.status){
            this.props.history.push('/');
        }
    }

    componentWillReceiveProps(props){
        if(props.login){
            localStorage.setItem('jwt', props.jwt);

        }else{
            this.setState({
                loginError: props.login_msg
            })
        }
    }

    async onRequestLogin(){
        const errors = {};
        if(!isEmail(this.state.email)){
            errors.email = `${this.state.email} is not a valid email.`
        }
        if(_.isEmpty(this.state.password)){
            errors.password = `${this.state.password} is not a valid.`
        }
        if(!_.isEmpty(errors)){
            this.setState({
                errors: errors
            })
        }
        try{
            const response = await  Api.login(this.state.email, this.state.password);
            const result = JSON.parse(response.text);
            if(result.status){
                localStorage.setItem("auth", JSON.stringify(result));
                location.href = '/';
            }
        }catch(err){
            alert(err.message)
        }
       // this.props.dispatch(requestLogin(this.state.email, this.state.password, this.state.remember));
        event.preventDefault();
    }

    handleKeyPress(event){
        if(event.key == 'Enter'){
            this.onRequestLogin();
        }
    }

    render(){
        return(
            <div className="login-box">
                <div className="login-logo">
                    <a href="../../index2.html"><b>Remy</b>hair</a>
                </div>
                <div className="login-box-body">
                    <p className="login-box-msg">Sign in to start your session</p>

                    <div >
                       <div className={ClassNames("form-group has-error", {"hide" : this.state.loginError ==''})}>
                           <span className="help-block">{this.state.loginError}</span>
                       </div>
                        <div className={"form-group has-feedback " + _.isEmpty(this.state.errors.email) ? '' :'has-error'}>
                            <input type="email" className="form-control" required placeholder="Email" value={this.state.email}
                                   onKeyPress={this.handleKeyPress}
                                   onChange={this.handleChangeEmail} />
                                <span className="glyphicon glyphicon-envelope form-control-feedback"></span>
                                <span className="help-block">{this.state.errors.email}</span>
                        </div>
                        <div className={"form-group has-feedback "+ _.isEmpty(this.state.errors.password) ? '' :'has-error'}>
                            <input type="password" className="form-control" placeholder="Password" value={this.state.password}
                                   onKeyPress={this.handleKeyPress}
                                   required onChange={this.handleChangePassword}/>
                                <span className="glyphicon glyphicon-lock form-control-feedback"></span>
                            <span className="help-block">{this.state.errors.password}</span>

                        </div>
                        <div className="row">
                            <div className="col-xs-4">
                                <button type="submit" onClick={this.onRequestLogin} className="btn btn-primary btn-block btn-flat">Sign In</button>
                            </div>
                        </div>
                    </div>

                    {/*<a href="#">I forgot my password</a>*/}
                    <br />
                </div>
            </div>
        )
    }
}
