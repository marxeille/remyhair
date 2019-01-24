export const REQUEST_LIST = 'saleCommission/REQUEST_LIST';
export const REQUEST_DETAIL_LIST = 'saleCommission/REQUEST_DETAIL_LIST';
export const RECEIVE_LIST = 'saleCommission/RECEIVE_LIST';
export const RECEIVE_DETAIL_LIST = 'saleCommission/RECEIVE_DETAIL_LIST';
export const REQUEST_FILTER = 'saleCommission/REQUEST_FILTER';
export const REQUEST_DETAIL_FILTER = 'saleCommission/REQUEST_DETAIL_FILTER';

export function requestGetList(jwt, filter = {}){
    return {
        type: REQUEST_LIST,
        jwt: jwt,
        data: filter
    }
}

export function requestGetDetailList(jwt, id){
    return {
        type: REQUEST_DETAIL_LIST,
        jwt: jwt,
        id: id
    }
}

export function receiveList(data){
    return {
        type: RECEIVE_LIST,
        data: data.data
    }
}

export function receiveDetailList(data){
    return {
        type: RECEIVE_DETAIL_LIST,
        data: data.data
    }
}

export function requestDetailFilter(data){
    return {
        type: REQUEST_DETAIL_FILTER,
        data: data
    }
}
