export const REQUEST_LIST = 'support/REQUEST_LIST'
export const RECEIVE_LIST = 'support/RECEIVE_LIST'
export const REQUEST_FILTER = 'support/REQUEST_FILTER'
export const REQUEST_ADD = 'support/REQUEST_ADD'
export const RECEIVE_ADD_SUPPORT = 'support/RECEIVE_ADD_SUPPORT'

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

export function requestFilter(data){
    return {
        type: REQUEST_FILTER,
        data: data
    }
}

export function receiveAddSupport(data){
    return {
        type: RECEIVE_ADD_SUPPORT,
        data: data
    }
}

export function requestAdd(data){
    return {
        type: REQUEST_ADD,
        data: data
    }
}


