import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import *  as _ from 'lodash'
import ClassNames from 'classnames'
import {hasRole} from "../../utility";

export default class NavigationMenu extends Component{
    constructor(props){
        super(props);
    }

    render(){
        const url = window.location.pathname;
        return (
            <aside className="main-sidebar">
                <section className="sidebar" >
                    <div className="user-panel">
                        <div className="pull-left image">
                            <img src="dist/img/user2-160x160.jpg" className="img-circle" alt="User Image" />
                        </div>
                        <div className="pull-left info">
                            <p>{this.props.employee.name}</p>
                            <a href="#"><i className="fa fa-circle text-success"></i> Online</a>
                        </div>
                    </div>
                    {/* sidebar menu: : style can be found in sidebar.less */}
                    <ul className="sidebar-menu">
                        <li className="header">MAIN NAVIGATION</li>
                        <li className="treeview" className={url == '/' ? 'active' : ''}>
                            <Link to={'/'}>
                                <i className="fa fa-dashboard"></i>
                                <span>
                                    Dashboard
                                </span>
                            </Link>
                        </li>
                        <li className="treeview" className={ClassNames({'hidden' : !hasRole('list-customer', this.props.actions), 'active': url.includes('/customer')})}>
                            <Link to={'/customer'}>
                                <i className="fa fa-user"></i>
                                <span>
                                    Customer
                                </span>
                            </Link>
                        </li>
                        <li className="treeview" className={ClassNames({'hidden' : !hasRole('list-support', this.props.actions), 'active': url.includes('/support')})}>
                            <Link to={'/support'}>
                                <i className="fa  fa-support"></i>
                                <span>Support</span>
                            </Link>
                        </li>
                        <li className={ClassNames({'hidden' : !hasRole('list-employee', this.props.actions), 'active': url.includes('employee')})} >
                            <Link to={'/employee'}>
                                <i className="fa fa-users"></i>
                                <span>Employee</span>
                            </Link>
                        </li>
                        <li className={ClassNames({'hidden' : !hasRole('list-workprofile', this.props.actions), 'active': url.includes('work-profile')})}>
                            <Link to={'/work-profile'}>
                                <i className="fa fa-briefcase"></i>
                                <span>Work profile</span>
                            </Link>
                        </li>
                        <li className="treeview" className={ClassNames({'hidden' : !hasRole('list-order', this.props.actions),  'active' : url.includes('/order')})}>
                            <Link to={'/order'}>
                                <i className="fa fa-clipboard"></i>
                                <span>Order</span>
                            </Link>
                        </li>
                        <li className="treeview" className={ url=='/sale' || url.includes('/sale/add') || url.includes('/sale/detail') || url.includes('/sale/edit') ? 'active' : ''}>
                            <Link to={'/sale'}>
                                <i className="fa fa-bookmark"></i>
                                <span>Sale</span>
                            </Link>
                        </li>
                        <li  className={ClassNames({'hidden' : !hasRole('report', this.props.actions), "treeview": true,
                            'active': url.includes('report')})}>
                            <a href="#">
                                <i className="fa fa-comment"></i>
                                <span>Report</span>
                                <i className="fa fa-angle-left pull-right"></i>
                            </a>
                            <ul className="treeview-menu menu-open" >
                                <li  className={ClassNames({'hidden' : !hasRole('render-customer-report', this.props.actions), "treeview": true,
                                    'active': url.includes('/report/customer')})}>
                                    <Link to="/report/customer">
                                        <i className="fa fa-user"></i>
                                        <span>Customer</span>
                                    </Link>
                                </li>
                                <li  className={ClassNames({'hidden' : !hasRole('report-order-list', this.props.actions), "treeview": true,
                                    'active': url.includes('/report/balance')})}>
                                    <Link to="/report/balance">
                                        <i className="fa fa-user"></i>
                                        <span>Customer balance</span>
                                    </Link>
                                </li>
                                <li  className={ClassNames({'hidden' : !hasRole('report-order-list', this.props.actions), "treeview": true,
                                    'active': url.includes('report')})}>
                                    <a href="#">
                                        <i className="fa fa-comment"></i>
                                        <span>Order</span>
                                        <i className="fa fa-angle-left pull-right"></i>
                                    </a>
                                    <ul className="treeview-menu menu-open" >
                                        <li className={ClassNames({'hidden' : !hasRole('report-order-list', this.props.actions), "treeview": true,
                                            'active': url.includes('/report/order/stats')})}>
                                            <Link to="/report/order/stats">
                                                <i className="fa fa-user"></i>
                                                <span>Order stats</span>
                                            </Link>
                                        </li>
                                        <li className={ClassNames({'hidden' : !hasRole('report-order-list', this.props.actions), "treeview": true,
                                            'active': url.includes('/report/order/summary')})}>
                                            <Link to="/report/order/summary">
                                                <i className="fa fa-clipboard"></i>
                                                <span>Order summary</span>
                                            </Link>
                                        </li>
                                        <li className={ClassNames({'hidden' : !hasRole('report-order-list', this.props.actions), "treeview": true,
                                            'active': url.includes('/report/order/type')})}>
                                            <Link to="/report/order/type">
                                                <i className="fa fa-clipboard"></i>
                                                <span>Product type</span>
                                            </Link>
                                        </li>
                                        <li className={ClassNames({'hidden' : !hasRole('report-order-list', this.props.actions), "treeview": true,
                                            'active': url.includes('/report/order/size')})}>
                                            <Link to="/report/order/size">
                                                <i className="fa fa-clipboard"></i>
                                                <span>Product size</span>
                                            </Link>
                                        </li>
                                        <li className={ClassNames({'hidden' : !hasRole('report-order-list', this.props.actions), "treeview": true,
                                            'active': url.includes('/report/order/country')})}>
                                            <Link to="/report/order/country">
                                                <i className="fa fa-clipboard"></i>
                                                <span>Country</span>
                                            </Link>
                                        </li>
                                        <li className={ClassNames({'hidden' : !hasRole('report-order-list', this.props.actions), "treeview": true,
                                            'active': url.includes('/report/order/customer')})}>
                                            <Link to="/report/order/customer">
                                                <i className="fa fa-clipboard"></i>
                                                <span>Customer</span>
                                            </Link>
                                        </li>
                                        <li className={ClassNames({'hidden' : !hasRole('report-order-list', this.props.actions), "treeview": true,
                                            'active': url.includes('/report/order/weft')})}>
                                            <Link to="/report/order/weft">
                                                <i className="fa fa-money"></i>
                                                <span>WEFT</span>
                                            </Link>
                                        </li>
                                        <li className={ClassNames({'hidden' : !hasRole('report-order-list', this.props.actions), "treeview": true,
                                            'active': url.includes('/report/order/stats')})}>
                                            <Link to="/report/order/closure">
                                                <i className="fa fa-money"></i>
                                                <span>CLOSURE</span>
                                            </Link>
                                        </li>
                                        <li className={ClassNames({'hidden' : !hasRole('report-order-list', this.props.actions), "treeview": true,
                                            'active': url.includes('/report/order/payment')})}>
                                            <Link to="/report/order/payment">
                                                <i className="fa fa-money"></i>
                                                <span>Payment method</span>
                                            </Link>
                                        </li>
                                    </ul>
                                </li>
                                <li className={ClassNames({'hidden' : !hasRole('sale-commission-list', this.props.actions), "treeview": true,
                                    'active': url.includes('/report/sale-commission')})}>
                                    <Link to="/report/sale-commission">
                                        <i className="fa fa-money"></i>
                                        <span>Sale commission</span>
                                    </Link>
                                </li>
                            </ul>
                        </li>
                        <li className="treeview" className={ClassNames({'hidden' : !hasRole('history-list', this.props.actions), 'active': url.includes('history')})}>
                            <Link to={'/history'}>
                                <i className="fa fa-history"></i>
                                <span>History</span>
                            </Link>
                        </li>

                        <li className={ClassNames({'treeview': true}, {'hidden': this.props.employee.id_group != 1},
                            (url == '/group' || url == '/hair/list/color' || url == '/hair/list/size' || url == '/hair/list/style' || url == '/hair/list/draw' || url == '/hair/list/type' || url=='/procedure' || url=='/order-states' || url=='/payment' || url=='/invoice') ? 'active' : '')}>
                            <a href="#">
                                <i className="fa fa-laptop"></i>
                                <span>Admin</span>
                                <i className="fa fa-angle-left pull-right"></i>
                            </a>
                            <ul className="treeview-menu menu-open" >
                                <li className={ClassNames({'hidden' : !hasRole('list-group', this.props.actions), 'active': url.includes('/group')})}>
                                    <Link to="/group">
                                        <i className="fa fa-cog"></i>
                                        <span>Permission</span>
                                    </Link>
                                </li>
                                <li className={ClassNames({'hidden' : !hasRole('list-group', this.props.actions), 'active': url.includes('/hair/list/color')})}>
                                    <Link to="/hair/list/color">
                                        <i className="fa fa-adjust"></i>
                                        <span>Hair Color</span>
                                    </Link>
                                </li>
                                <li className={ClassNames({'hidden' : !hasRole('list-group', this.props.actions), 'active': url.includes('/hair/list/size')})}>
                                    <Link to="/hair/list/size">
                                        <i className="fa fa-window-maximize"></i>
                                        <span>Hair Size</span>
                                    </Link>
                                </li>
                                <li className={ClassNames({'hidden' : !hasRole('list-group', this.props.actions), 'active': url.includes('/hair/list/style')})}>
                                    <Link to="/hair/list/style">
                                        <i className="fa fa-tint"></i>
                                        <span>Hair Style</span>
                                    </Link>
                                </li>
                                <li className={ClassNames({'hidden' : !hasRole('list-group', this.props.actions), 'active': url.includes('/hair/list/draw')})}>
                                    <Link to="/hair/list/draw">
                                        <i className="fa fa-eraser"></i>
                                        <span>Hair Draw</span>
                                    </Link>
                                </li>
                                <li className={ClassNames({'hidden' : !hasRole('list-group', this.props.actions), 'active': url.includes('/hair/list/type')})}>
                                    <Link to="/hair/list/type">
                                        <i className="fa fa-magic"></i>
                                        <span>Hair Type</span>
                                    </Link>
                                </li>
                                <li className={ClassNames({'hidden' : !hasRole('list-procedure', this.props.actions), 'active': url.includes('/procedure')})}>
                                    <Link to="/procedure">
                                        <i className="fa fa-archive"></i>
                                        <span>Work procedure</span>
                                    </Link>
                                </li>
                                <li className={ClassNames({'hidden' : !hasRole('remove-order-state', this.props.actions), 'active': url.includes('/order-states')})}>
                                    <Link to="/order-states">
                                        <i className="fa fa-first-order"></i>
                                        <span>Order state</span>
                                    </Link>
                                </li>
                                <li className={ClassNames({'hidden' : !hasRole('payment-list', this.props.actions), 'active': url.includes('/payment')})}>
                                    <Link to="/payment">
                                        <i className="fa fa-shopping-cart"></i>
                                        <span>Payment</span>
                                    </Link>
                                </li>
                                <li className={ClassNames({'hidden' : !hasRole('invoice-list', this.props.actions), 'active': url.includes('/invoice')})}>
                                    <Link to="/invoice">
                                        <i className="fa fa-money"></i>
                                        <span>Invoice status</span>
                                    </Link>
                                </li>
                                <li className={ClassNames({'hidden' : !hasRole('job-title-list', this.props.actions), 'active': url.includes('/job-title')})}>
                                    <Link to="/job-title">
                                        <i className="fa fa-user-md"></i>
                                        <span>Job title</span>
                                    </Link>
                                </li>
                                <li>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </section>
            </aside>
        )
    }
}
