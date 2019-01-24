import React, { Component } from 'react'
import {updateBalance} from "../../actions/order/cart";
import * as _ from "lodash";
import ClassNames from "classnames";

export default class CustomerBalance extends Component{
    constructor(props) {
        super(props);
        this.state = {
            errors:{},
            balance: this.props.cart.summary.customer_balance
        };
        this.updateBalance = this.updateBalance.bind(this);
        this.handleChangeBalance = this.handleChangeBalance.bind(this);
    }

    updateBalance(){
        localStorage.setItem('cartCustomerBalance', this.state.balance);
        this.props.dispatch(updateBalance(this.props.jwt, {...this.props.cart, balance: this.state.balance}, this.props.isEditing));
    }

    componentWillReceiveProps(nextProps){
        if(!_.isEqual(this.props.cart.summary.customer_balance, nextProps.cart.summary.customer_balance)){
            this.setState({
                balance: nextProps.cart.summary.customer_balance,
            });
            localStorage.setItem('cartCustomerBalance', nextProps.cart.summary.customer_balance)
        }
    }

    handleChangeBalance(event){
        let  balance = (true)
        ? event.target.value : this.state.balance
        this.setState({
             balance: balance
        })
    }

    render(){
        const {balance, errors} = this.state;
        return(
            <div className="group-input">
                <span className="label-detail">Balance</span>
                <div className="group-input-content">
                    <span className="group-label-input">
                        <label>$</label>
                            <input 
                                type="text"  
                                value={balance}
                                className={ClassNames({'error': errors.discount})} 
                                onChange={(event) => this.handleChangeBalance(event)}
                                onBlur={this.updateBalance} />
                    </span>
                </div>
            </div>
        )
    }
}
