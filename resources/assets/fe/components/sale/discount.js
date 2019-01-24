import React, { Component } from 'react'
import {updateDiscount} from "../../actions/order/cart";
import * as _ from "lodash";
import ClassNames from "classnames";

export default class Discount extends Component{
    constructor(props) {
        super(props);
        this.state = {
            errors:{},
            cart: this.props.cart,
        };
        this.updateDiscount = this.updateDiscount.bind(this)
        this.handleChangeDiscount = this.handleChangeDiscount.bind(this)
    }

    updateDiscount(){
        if(this.state.cart.discount){
            this.props.dispatch(updateDiscount(this.props.jwt, this.state.cart, this.props.isEditing));
        }
    }

    componentWillReceiveProps(nextProps){
        this.setState({
            cart: nextProps.cart,
        })
    }

    handleChangeDiscount(event){
        let { cart } = this.state;
        let  discount = (_.isNull(event.target.value.match(/[^0-9.-]/)) && event.target.value <= cart.summary.total.sale)
        ? event.target.value : cart.discount
        this.setState({
            cart: Object.assign({}, this.state.cart, {
                discount:discount,
            }),
            errors: Object.assign({}, this.state.errors, {discount: !event.target.value})
        })    
    }

    render(){
        const {cart, errors} = this.state;
        return(
            <div className="group-input">
                <span className="label-detail">Discount</span>
                <div className="group-input-content">
                    <span className="group-label-input">
                        <label>$</label>
                            <input 
                                type="text"  
                                value={cart.discount ? cart.discount : ''} 
                                className={ClassNames({'error': errors.discount})} 
                                onChange={(event) => this.handleChangeDiscount(event)}
                                onBlur={this.updateDiscount} />
                    </span>
                </div>
            </div>
        )
    }
}
