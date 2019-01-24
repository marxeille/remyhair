export const REQUEST_LIST = 'history/REQUEST_LIST'
export const RECEIVE_LIST = 'history/RECEIVE_LIST'
export const REQUEST_FILTER = 'history/REQUEST_FILTER'

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


