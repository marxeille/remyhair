export const REQUEST_INIT_CART = 'cart/REQUEST_INIT_CART';
export const RECEIVE_INIT_CART = 'cart/RECEIVE_INIT_CART';
export const ASSIGN_CUSTOMER = 'cart/ASSIGN_CUSTOMER';
export const UPDATE_CART = 'cart/UPDATE_CART';
export const UPDATE_SHIPPING_COST = 'cart/UPDATE_SHIPPING_COST';
export const UPDATE_DISCOUNT = 'cart/UPDATE_DISCOUNT';
export const UPDATE_CARRIER = 'cart/UPDATE_CARRIER';
export const UPDATE_ADDRESS = 'cart/UPDATE_ADDRESS';
export const UPDATE_SALEMAN = 'cart/UPDATE_SALEMAN';
export const REQUEST_UPDATE_ADDRESS = 'cart/REQUEST_UPDATE_ADDRESS';
export const REQUEST_UPDATE_CUSTOMER = 'cart/REQUEST_UPDATE_CUSTOMER';
export const CLEAR_CUSTOMER = 'cart/CLEAR_CUSTOMER';
export const CLEAR_ADDRESS = 'cart/CLEAR_ADDRESS';
export const ADD_ADDRESS = 'cart/ADD_ADDRESS';
export const COMPLETE_ORDER = 'cart/COMPLETE_ORDER';
export const UPDATE_PAYMENT_FEE = 'cart/UPDATE_PAYMENT_FEE';
export const RECEIVE_ORDER = 'sale/RECEIVE_ORDER';
export const CANCEL_ORDER = 'sale/CANCEL_ORDER';
export const UPDATE_BALANCE = 'sale/UPDATE_BALANCE';

export function requestInitCart(jwt) {
    return {
        type: REQUEST_INIT_CART,
        jwt: jwt
    }
}

export function receiveInitCart(data, isEditing = false) {
    return {
        type: RECEIVE_INIT_CART,
        data: data,
        isEditing: isEditing
    }
}


export function assignCustomer(cart) {
    return {
        type: ASSIGN_CUSTOMER,
        cart: cart
    }
}

export function assignAddress(address) {
    return {
        type: UPDATE_ADDRESS,
        data: address
    }
}

export function updateCart(cart) {
    return {
        type: UPDATE_CART,
        cart: cart
    }
}

export function requestUpdateAddress(jwt, address, idCart) {
    return {
        type: REQUEST_UPDATE_ADDRESS,
        data: {
            jwt: jwt,
            address: address,
            idCart: idCart
        }
    }
}

export function requestUpdateCustomer(jwt, customer) {
    return {
        type: REQUEST_UPDATE_CUSTOMER,
        data: {
            jwt: jwt,
            customer: customer
        }
    }
}

export function updateShippingCost(jwt, cart, isEditing = false) {
    return {
        type: UPDATE_SHIPPING_COST,
        data: {
            jwt:jwt,
            data: cart
        },
        isEditing: isEditing
    }
}

export function clearCustomer(jwt, idCart, onSuccess) {
    return {
        type: CLEAR_CUSTOMER,
        data: {
            jwt:jwt,
            idCart: idCart,
            onSuccess: onSuccess
        }
    }
}

export function clearAddress(onSuccess) {
    return {
        type: CLEAR_ADDRESS,
        data: {
            onSuccess: onSuccess
        }
    }
}

export function updateCarrier(jwt, cart, isEditing = false) {
    return {
        type: UPDATE_CARRIER,
        data: {
            jwt: jwt,
            data: cart
        },
        isEditing: isEditing
    }
}

export function updateDiscount(jwt, cart, isEditing = false) {
    return {
        type: UPDATE_DISCOUNT,
        data: {
            jwt: jwt,
            data: cart
        },
        isEditing: isEditing
    }
}

export function updateBalance(jwt, cart, isEditing = false) {
    return {
        type: UPDATE_BALANCE,
        data: {
            jwt: jwt,
            cart: cart
        },
        isEditing: isEditing
    }
}

export function updatePaymentFee(jwt, cart, isEditing = false) {
    return {
        type: UPDATE_PAYMENT_FEE,
        data: {
            jwt: jwt,
            data: cart
        },
        isEditing: isEditing
    }
}

export function saveNote(note) {
    return {
        type: UPDATE_DISCOUNT,
        data: {
            jwt: jwt,
            data: cart
        }
    }
}

export function addAddress(jwt, address, idCart) {
    return {
        type: ADD_ADDRESS,
        data: {
            jwt: jwt,
            address: address,
            idCart: idCart
        }
    }
}

export function completeOrder(jwt, order, editingOrder = null, onSuccess) {
    return {
        type: COMPLETE_ORDER,
        data: {
            jwt:jwt,
            order: order,
            editingOrder: editingOrder,
            onSuccess:onSuccess
        }
    }
}

export function receiveOrder(order) {
    return {
        type: RECEIVE_ORDER,
        data: {
            order: order
        }
    }
}

export function cancelOrder(jwt) {
    return {
        type: CANCEL_ORDER,
        data: {
            jwt:jwt
        }
    }
}

export function updateSaleMan(jwt,cart, isEditing = false) {
    return {
        type: UPDATE_SALEMAN,
        data: {
            jwt:jwt,
            cart:cart
        },
        isEditing: isEditing
    }
}

