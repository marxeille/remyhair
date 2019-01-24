import {
    RECEIVE_INIT_CART,
    RECEIVE_ORDER, UPDATE_BALANCE,
    UPDATE_CART
} from "../actions/order/cart";
import * as _ from 'lodash'

const init = {
    cart: {},
    initData: {},
    order: {},
    isEditing: false
};

export default function sale(state = init, action) {
	switch (action.type) {
        case RECEIVE_INIT_CART:{
            localStorage.setItem('idCart', action.data.cart.id);
            return Object.assign({}, state, {
                cart: action.data.cart,
                initData: !_.isEmpty(action.data.init_data) ? action.data.init_data : state.initData,
                isEditing: action.isEditing ? state.isEditing : action.data.is_editing,
                order: action.isEditing ? state.order : action.data.order
            })
        }
       
        case UPDATE_CART:{
            if (localStorage.getItem('idCart') == null) {
                localStorage.setItem('idCart', action.cart.id);
            }
            return Object.assign({}, state, {
                cart: Object.assign({}, state.cart, action.cart)
            })
        }

        case UPDATE_BALANCE:{
            if (localStorage.getItem('idCart') == null) {
                localStorage.setItem('idCart', action.cart.id);
            }
            return Object.assign({}, state, {
                cart: Object.assign({}, state.cart, action.data.cart)
            })
        }

        case RECEIVE_ORDER:{
            return Object.assign({}, state, {
                order: action.data.order
            })
        }
		default:
			return state;
	}
}

