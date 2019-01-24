import React, {PureComponent} from 'react';
import {renderAddress} from "../../../utility";

export default class Customer extends PureComponent{
    render(){
        const { countries, states} = this.props.env;
        return(
            <div className="col-sm-4 invoice-col">
                <span><strong>Customer</strong> </span>
                <address>
                    {this.props.customer.full_name}<br />
                    {renderAddress(this.props.address, countries, states)}<br/>
                    Phone: {`${this.props.customer.phone}`}<br/>
                    Email: {`${this.props.customer.email}`}<br/>
                </address>
            </div>
        )
    }
}
