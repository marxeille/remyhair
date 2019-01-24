
import React, {Component} from 'react'
import HeaderMessages from './header-messages/header-messages'
import HeaderNotifications from './header-notifications/header-notifications'
import HeaderTasks from './header-tasks/header-tasks'
import {requestLogout} from "../../../actions/env";

export default class HeaderBar extends Component{
    constructor(props){
        super(props);
    }

    pushMenu() {
        var body = document.body;
        if(body.clientWidth > 768){
            if(body.className.indexOf('sidebar-collapse') === -1){
                body.className += ' sidebar-collapse';
            }else {
                body.className = body.className.replace(' sidebar-collapse', '');
            }
        }else{
            if (body.className.indexOf('sidebar-open') === -1) {
                body.className += ' sidebar-open';
            }else{
                body.className = body.className.replace(' sidebar-open','');
            }
        }
    }

    logOut(){
        this.props.dispatch(requestLogout());
    }

    render() {
        var that = this;
        return (
            <header className="main-header">
                {/* Logo */}
                <a href="/" className="logo">
                    {/* mini logo for sidebar mini 50x50 pixels */}
                    <span className="logo-mini"><b>A</b>LT</span>
                    {/* logo for regular state and mobile devices */}
                    <span className="logo-lg"><b>Admin</b>LTE</span>
                </a>
                {/* Header Navbar: style can be found in header.less */}
                <nav className="navbar navbar-static-top" role="navigation">
                    {/* Sidebar toggle button*/}
                    <a href="#" className="sidebar-toggle" data-toggle="offcanvas" role="button" onClick={that.pushMenu}>
                        <span className="sr-only">Toggle navigation</span>
                    </a>
                    <div className="navbar-custom-menu">
                        <ul className="nav navbar-nav">
                            {/* Messages: style can be found in dropdown.less*/}
                            <HeaderMessages />
                            {/* Notifications: style can be found in dropdown.less */}
                            <HeaderNotifications />
                            {/* Tasks: style can be found in dropdown.less */}
                            <HeaderTasks />
                            {/* User Account: style can be found in dropdown.less */}
                            <li className="user user-menu">
                                <a href="#" onClick={this.logOut.bind(this)}>
                                    <span className="hidden-xs">Sign out</span>
                                </a>

                            </li>
                            { /* Control Sidebar Toggle Button */}
                            <li>
                                <a href="#" data-toggle="control-sidebar"><i className="fa fa-gears"></i></a>
                            </li>
                        </ul>
                    </div>
                </nav>
            </header>
        )
    }
}
