import React, { Component } from 'react'
import * as _ from "lodash";
import {renderAddress} from "../../utility";

export default class Customer extends Component{
    constructor(props){
        super(props);

        this.changeAddress = this.changeAddress.bind(this);
    }

    changeAddress(){
        this.props.changeModal('changeAddress');
    }

    render(){
        const { cart, countries, states } = this.props;
        const address = _.find(cart.customer.address, (add) => { return cart.id_address == add.id; });
        const customer = cart.customer;
        return(
            <div className={"showPopupCustomer"}>
                <div className="view-title"><h4 className="title-form">Address</h4></div>
                <span><label>Customer Name:</label> {`${customer.full_name}`}</span>
                <div>
                    <span>{renderAddress(address, countries, states )}</span>
                </div>
                <div className="btn-change-address-container">
                <button className={'btn btn-flat btn-change-address'} onClick={this.changeAddress}>change</button>
                </div>
            </div>
        )
    }
}
