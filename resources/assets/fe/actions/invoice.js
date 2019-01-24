export const ADD_INVOICE = 'invoice/ADD_PAYMENT';
export const RECEIVE_NEW_INVOICE = 'invoice/RECEIVE_NEW_INVOICE';
export const RECEIVE_DEL_INVOICE = 'invoice/RECEIVE_DEL_INVOICE';
export const REQUEST_LIST = 'invoice/REQUEST_LIST';
export const RECEIVE_LIST = 'invoice/RECEIVE_LIST';
export const REQUEST_FILTER = 'invoice/REQUEST_FILTER';
export const REQUEST_INVOICE = 'invoice/REQUEST_INVOICE';
export const RECEIVE_INVOICE = 'invoice/RECEIVE_INVOICE';

export function receiveNewInvoice(data){
    return {
        type: RECEIVE_NEW_INVOICE,
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

export function requestInvoice(jwt, id){
    return {
        type: REQUEST_INVOICE,
        data: {
            jwt: jwt,
            id: id
        },
    }
}

export function receiveInvoice(data){
    return {
        type: RECEIVE_INVOICE,
        data: data
    }
}


