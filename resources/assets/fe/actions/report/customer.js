export const REQUEST_LIST = 'report/customer/REQUEST_LIST'
export const RECEIVE_LIST = 'report/customer/RECEIVE_LIST'
export const REQUEST_FILTER = 'report/customer/REQUEST_FILTER'

export function requestGetList(jwt){
    return {
        type: REQUEST_LIST,
        jwt: jwt
    }
}

export function receiveListCustomers(data){
    return {
        type: RECEIVE_LIST,
        data: data.data
    }
}

export function requestFilter(data){
    return {
        type: REQUEST_FILTER,
        data: data
    }
}



