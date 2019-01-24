import React, { Component } from 'react'
import AddProduct from "./product/addProduct";
import Popup from "reactjs-popup";
import Loading from "../layout/loading";
import {requestInitCart, updateCarrier, updateSaleMan, updateShippingCost} from "../../actions/order/cart";
import * as _ from 'lodash'
import Products from "./product/products";
import AssignCustomer from "./assignCustomer";
import ClassNames from "classnames";
import Shipping from "./shipping";
import Discount from "./discount";
import Summary from "./summary";
import ImportProduct from "./product/importProduct";
import OrderNote from "./orderNote";

import OrderAction from "./orderAction";
import ChangeAddress from "./changeAddress";
import Customer from "./customer";
import AddPayment from "./addPayment";
import PaymentFee from "./paymentFee";
import CustomerBalance from "./customerBalance";

export default class Sale extends Component{
    constructor(props){
        super(props);
        this.state = {
            modals: {addProduct: false},
            isFetching: _.isEmpty(this.props.cart),
            img: localStorage.getItem('image'),
            errors:{},
        };

        this.showAddProduct = this.showAddProduct.bind(this);
        this.onClosePopUp = this.onClosePopUp.bind(this);
        this.removeCarrier = this.removeCarrier.bind(this);
        this.showModal = this.showModal.bind(this);
        this.changeModal = this.changeModal.bind(this);
        this.onCancelOrder = this.onCancelOrder.bind(this);
        this.onChangeCustomerBalance = this.onChangeCustomerBalance.bind(this);
    }

    onClosePopUp(){
       this.setState({
           modals: this.modals
       })
    }

    componentWillMount(){
        if(_.isEmpty(this.props.cart)){
            let idCart = localStorage.getItem('idCart');
            this.props.dispatch(requestInitCart(this.props.jwt, idCart));
        }
    }

    componentWillReceiveProps(nextProps){
          this.setState({
            isFetching: false
        });  
    }

    onAddProductSuccess(data){
        this.onClosePopUp();
    }

    onCancelOrder(){
        localStorage.removeItem('note')
        localStorage.removeItem('image')
        localStorage.removeItem('reason')
        localStorage.removeItem('idCart')
        this.setState({
            isFetching: true,
            img: null
        })
    }

    showModal(){
        const modalKey = _.invert(this.state.modals, true)['true'];
        if(modalKey){
            const { initData, cart, isEditing, order } = this.props;
            let modal;
            switch (modalKey) {
                case 'addProduct':
                    modal = <AddProduct isEditing={isEditing} initData={initData} cart={cart} jwt={this.props.jwt} onClose={this.onClosePopUp} dispatch={this.props.dispatch} onSuccess={this.onAddProductSuccess.bind(this)} />;
                    break;
                case 'changeAddress':
                    modal = <ChangeAddress cart={cart} jwt={this.props.jwt} countries={this.props.countries} states={this.props.states} onClose={this.onClosePopUp} dispatch={this.props.dispatch} />;
                    break;
                case 'customer':
                    modal = <Customer cart={cart} jwt={this.props.jwt} countries={this.props.countries} dispatch={this.props.dispatch} states={this.props.states}  changeModal = {this.changeModal} />;
                    break;
                case 'addPayment':
                    modal = <AddPayment isEditing={isEditing} order={order} jwt={this.props.jwt} initData={initData} cart={cart} dispatch={this.props.dispatch} onCancelOrder={this.onCancelOrder} />;
                    break;
                default :
                    modal = '';
                    break;
            }
            return (
                <Popup open={this.state.modals[modalKey]} onClose={this.onClosePopUp.bind(this)}>
                    { modal }
                </Popup>
            )
        }
    }

    changeModal(modal){
        this.setState({
            modals: Object.assign({}, this.modals, {
                [modal]: true
            })
        })
    }

    showAddProduct(){
        this.setState({
            modals: Object.assign({}, this.modals, {
                addProduct: true
            })
        })
    }

    removeCarrier(){
        this.setState({
            cart: Object.assign({}, this.state.cart, {
                id_carrier: null
            })
        })
    }

    onChangeCustomerBalance(event){
        this.setState({
            cart: Object.assign({}, this.state.cart, {
                balance:  (_.isNull( event.target.value.match(/[^0-9.-]/)) &&  event.target.value <= this.state.cart.summary.customer_balance)
                    ? event.target.value : this.state.cart.balance
            })
        })
    }

    render(){
        const { isFetching } = this.state;
        const { products, initData, cart, isEditing, order } = this.props;
        if(isFetching) return <Loading/>;
        if(cart.balance == undefined && !_.isEmpty(cart.customer)){
            cart.balance = cart.summary.customer_balance
        }
        return(
            <div>
                {this.showModal()}
            	<div className="orderHeader">
            		<div className="upload-file">
	            		<ImportProduct jwt={this.props.jwt} isEditing={isEditing} dispatch={this.props.dispatch} onSuccess={this.onAddProductSuccess.bind(this)}  idCart={cart.id} initData={initData} />
		            	<button onClick={this.showAddProduct} >Add Product</button>
                        {isEditing &&
                            <div>
                                <span><b># order: {order.id}</b></span>
                            </div>
                        }
	            	</div>
	            	<AssignCustomer jwt={this.props.jwt} dispatch={this.props.dispatch} cart={cart} countries={this.props.countries}
                                    customer={cart.customer}
                                    address={cart.address}
                                    states={this.props.states}
                                    changeModal = {this.changeModal}
                                    isEditing={isEditing}
                    />
            	</div>
                <div className="orderContent">
                    <Products products={products} isEditing={isEditing} jwt={this.props.jwt} dispatch={this.props.dispatch} initData={initData}/>
                </div>
            	<div className="orderContent">
            		<div className="container-note-discount">
                        <OrderNote cart={cart} isEditing={isEditing} order={order} dispatch={this.props.dispatch}/>
                      <div className="list-detail-order">
                            <div className="group-input">
                                <span className="label-detail">Sale Man</span>
                                        <div className="group-input-content">
                                        <select defaultValue={cart.id_employee ? cart.id_employee : this.props.employee.id} onChange={(e) => {
                                            this.setState({
                                                cart: Object.assign({}, this.state.cart, {
                                                    id_employee: e.target.value
                                                })
                                                    });
                                                    this.props.dispatch(updateSaleMan(this.props.jwt, Object.assign({}, cart, {
                                                        id_employee: e.target.value
                                                    }), isEditing))
                                                }}
                                        >
                                            {initData.sale_men.map((saleman) => (
                                                <option value={saleman.id} key={saleman.id}>{saleman.name}</option>
                                            ))}
                                        </select>
                                          </div>
                            </div>
                            <CustomerBalance jwt={this.props.jwt} isEditing={isEditing} cart={cart} dispatch={this.props.dispatch} />
                            <Shipping jwt={this.props.jwt} isEditing={isEditing} carriers={initData.carriers} cart={cart} dispatch={this.props.dispatch} removeCarrier={this.removeCarrier} />
                            <Discount jwt={this.props.jwt} isEditing={isEditing} cart={cart} dispatch={this.props.dispatch}  />
                            <PaymentFee jwt={this.props.jwt} isEditing={isEditing} cart={cart} dispatch={this.props.dispatch}  />
                      </div>
                  </div>
            	</div>
                <div className="orderFooter">
                    <Summary cart={cart} isEditing={isEditing} order={order} />
                    <OrderAction jwt={this.props.jwt} dispatch={this.props.dispatch} order={order} isEditing={isEditing} cart={cart} initData={initData} onCancelOrder={this.onCancelOrder} onCancelOrder={this.onCancelOrder} changeModal={this.changeModal} />
                </div>
            </div>
        )
    }
}
