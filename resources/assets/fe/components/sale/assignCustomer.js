import React, { Component } from 'react'
import {requestSearch} from "../../actions/customer";
import * as _ from 'lodash'
import {
    clearCustomer,
    requestUpdateCustomer
} from "../../actions/order/cart";
import {showPrice} from "../../utility";

export default class AssignCustomer extends Component{
    constructor(props){
        super(props);
        this.state = {
            keyword: '',
            customer: this.props.cart.customer
        };
        this.onSuccess = this.onSuccess.bind(this);
        this.assignCustomer = this.assignCustomer.bind(this);
        this.clearCustomer = this.clearCustomer.bind(this);
        this.showChangeAddressPopUp = this.showChangeAddressPopUp.bind(this);
    }

    onSuccess(customers){
        this.setState({
            customers: customers
        })
    }

    onChangeKeyWord(event){
        this.setState({
            keyword:event.target.value
        });
       this.onSearchCustomer();
    }

    onSearchCustomer(){
        const { keyword } = this.state;
        if(keyword.length >= 2){
            this.props.dispatch(requestSearch(this.props.jwt, keyword, this.onSuccess))
        }
    }

    assignCustomer(customer){
        this.props.dispatch(requestUpdateCustomer(this.props.jwt, {id_cart: this.props.cart.id, ...customer}));
        this.setState({
            customer:customer,
            customers: []
        })
    }

    clearCustomer(){
        this.props.dispatch(clearCustomer(this.props.jwt, this.props.cart.id,this.onClearCustomerSuccess));
        this.setState({
            customer:{},
            customers: []
        })
    }

    showChangeAddressPopUp(){
        this.props.changeModal('changeAddress');
    }

    componentDidMount() {
        this.onSearchCustomer =  _.debounce(this.onSearchCustomer, 500);      
    }

    render(){
        return(
            <div className="assignCustomerContainer">
                {!_.isEmpty(this.state.customer) ?
                    <div className="choose-customer">
                        <a href={'javascript:void(0)'} onClick={(e) => this.props.changeModal('customer')}>{this.state.customer.full_name}(balance: {showPrice(this.state.customer.customer_balance)})</a>
                        {!this.props.isEditing &&
                          <button className={'btn btn-flat btn-delete-customer'} onClick={this.clearCustomer} ><i className="fa fa-times"></i></button>
                        }
                     </div>
                    :
                    <div>
                        <div className="search-form">
                            <div className="inputSearch">
                                <i className="fa fa-user"></i>
                                <input 
                                    type="text" 
                                    value={this.state.key} 
                                    placeholder="Search for a customer" 
                                    onChange={(event) => this.onChangeKeyWord(event)} 
                                />
                            </div>
                            <button onClick={this.search}><i className="fa fa-search"></i></button>
                        </div>
                        {(!_.isEmpty(this.state.customers) ) &&
                             <div className="customerSuggest">
                                <ul>
                                    {
                                        this.state.customers.map((customer) => (
                                            <li key={customer.id} onClick={this.assignCustomer.bind(this, customer)}>
                                                <a href={'javascript:void(0)'}>{customer.full_name}</a>
                                            </li>)
                                        )
                                    }
                                </ul>
                            </div>}
                        </div>
                }
            </div>
        )
    }
}
