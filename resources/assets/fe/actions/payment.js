export const ADD_PAYMENT = 'payment/ADD_PAYMENT';
export const RECEIVE_NEW_PAYMENT = 'payment/RECEIVE_NEW_PAYMENT';
export const RECEIVE_DEL_PAYMENT = 'payment/RECEIVE_DEL_PAYMENT';
export const REQUEST_LIST = 'payment/REQUEST_LIST';
export const RECEIVE_LIST = 'payment/RECEIVE_LIST';
export const REQUEST_FILTER = 'payment/REQUEST_FILTER';
export const REQUEST_PAYMENT = 'payment/REQUEST_PAYMENT';
export const RECEIVE_PAYMENT = 'payment/RECEIVE_PAYMENT';

export function receiveNewPayment(data){
    return {
        type: RECEIVE_NEW_PAYMENT,
        data: data
    }
}

export function receiveDelHair(data){
    return {
        type: RECEIVE_DEL_HAIR,
        data: data
    }
}

export function requestGetList(data){
    return {
        type: REQUEST_LIST,
        data: data,
    }
}

export function receiveList(data){
    return {
        type: RECEIVE_LIST,
        data: data
    }
}

export function requestFilter(data){
    return {
        type: REQUEST_FILTER,
        data: data,
      
    }
}

export function requestPayment(jwt, id){
    return {
        type: REQUEST_PAYMENT,
        data: {
            jwt: jwt,
            id: id
        },
    }
}

export function receivePayment(data){
    return {
        type: RECEIVE_PAYMENT,
        data: data
    }
}


