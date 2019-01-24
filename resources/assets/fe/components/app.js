import React, { Component } from 'react';
import { Redirect } from 'react-router-dom'
import HeaderBar from './layout/header-bar/header-bar'
import NavigationMenu from './layout/navigation-menu'
import RouterPath from "../router";
import * as $ from 'jquery'
import Loading from "./layout/loading";
import Login from "../containers/login";

export default class App extends Component{
   
    render(){
        const authInfo = JSON.parse(localStorage.getItem('auth'));
        const { employee, isInited} = this.props;
        $('#root').addClass('wrapper');
        return (
            <div className="wrapper">
                { !authInfo ?
                    <div>
                        <Redirect to='/login'/>
                        <Login />
                    </div>
                 :
                    !isInited ? 
                        <Loading/> 
                    :
                        <div>
                            <HeaderBar employee={employee} dispatch={this.props.dispatch}/>
                            <NavigationMenu employee={employee} actions={this.props.actions}/>
                            <section className="content-wrapper">
                                <section className="content">
                                    <RouterPath />
                                </section>
                            </section>
                        </div>
                }
            </div>
        )
    }
}
