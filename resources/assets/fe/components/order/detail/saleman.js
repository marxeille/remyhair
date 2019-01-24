import React, {PureComponent} from 'react';

export default class SaleMan extends PureComponent{
    render(){
        return(
            <div className="col-sm-4 invoice-col">
                <span><strong>Saleman</strong></span>
                <address>
                    {`${this.props.employee.name}`}<br/>
                    Phone: {`${this.props.employee.phone}`}<br/>
                    Email: {`${this.props.employee.email}`}<br/>
                </address>
            </div>
        )
    }
}
