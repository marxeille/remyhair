export const REQUEST_LIST = 'customer/REQUEST_LIST';
export const RECEIVE_LIST = 'customer/RECEIVE_LIST';
export const REQUEST_UNSUPPORT_LIST = 'customer/REQUEST_UNSUPPORT_LIST';
export const RECEIVE_UNSUPPORT_LIST = 'customer/RECEIVE_UNSUPPORT_LIST';
export const REQUEST_FILTER = 'customer/REQUEST_FILTER';
export const REQUEST_FILTER_UNSUPPORT = 'customer/REQUEST_FILTER_UNSUPPORT';
export const REQUEST_ADD = 'customer/REQUEST_ADD';
export const RECEIVE_ADD_CUSTOMER = 'customer/RECEIVE_ADD_CUSTOMER';
export const REQUEST_IMPORT_CUSTOMERS = 'customer/REQUEST_IMPORT_CUSTOMERS';
export const REQUEST_SEARCH_CUSTOMER = 'customer/REQUEST_SEARCH_CUSTOMER';
export const RECEIVE_SEARCH_CUSTOMER = 'customer/REQUEST_SEARCH_CUSTOMER';
export const REQUEST_DELETE_CUSTOMER = 'customer/REQUEST_DELETE_CUSTOMER';
export const RECEIVE_DELETE_CUSTOMER = 'customer/RECEIVE_DELETE_CUSTOMER';

export function requestGetList(jwt){
    return {
        type: REQUEST_LIST,
        jwt: jwt
    }
}

export function receiveList(data){
    return {
        type: RECEIVE_LIST,
        data: data.data
    }
}

export function requestGetUnSupportList(jwt){
    return {
        type: REQUEST_UNSUPPORT_LIST,
        jwt: jwt
    }
}

export function receiveUnSupportList(data){
    return {
        type: RECEIVE_UNSUPPORT_LIST,
        data: data.data
    }
}

export function receiveAddCustomer(data){
    return {
        type: RECEIVE_ADD_CUSTOMER,
        data: data
    }
}

export function requestFilter(data){
    return {
        type: REQUEST_FILTER,
        data: data
    }
}

export function requestFilterUnSupport(data){
    return {
        type: REQUEST_FILTER_UNSUPPORT,
        data: data
    }
}

export function requestAdd(data){
    return {
        type: REQUEST_ADD,
        data: data
    }
}

export function requestSearch(jwt, key, onSuccess, onError){
    return {
        type: REQUEST_SEARCH_CUSTOMER,
        data: {
            jwt: jwt,
            key: key,
            onError: onError,
            onSuccess: onSuccess
        }
    }
}

export function receiveDeleteCustomer(id){
    return {
        type: RECEIVE_DELETE_CUSTOMER,
        data: {
           id: id
        }
    }
}

export function requestDeleteCustomer(jwt, id){
    return {
        type: REQUEST_DELETE_CUSTOMER,
        data: {
            jwt: jwt,
            id: id,
        }
    }
}

export function requestImportCustomers(jwt, data, idCart, onSuccess, onError) {
    return {
        type: REQUEST_IMPORT_CUSTOMERS,
        data: {
            jwt:jwt,
            data: {
                id: idCart,
                customers: data
            },
            onError: onError,
            onSuccess: onSuccess,
        }
    }
}

