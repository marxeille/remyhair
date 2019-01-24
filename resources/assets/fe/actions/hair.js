export const REQUEST_LEADERS = 'hair/REQUEST_LEADERS'
export const RECEIVE_LEADERS = 'hair/RECEIVE_LEADERS'
export const ADD_HAIR = 'hair/ADD_HAIR'
export const RECEIVE_NEW_HAIR = 'hair/RECEIVE_NEW_HAIR'
export const RECEIVE_DEL_HAIR = 'hair/RECEIVE_DEL_HAIR'
export const REQUEST_LIST = 'hair/REQUEST_LIST'
export const RECEIVE_LIST = 'hair/RECEIVE_LIST'
export const REQUEST_FILTER = 'hair/REQUEST_FILTER'
export const REQUEST_HAIR = 'hair/REQUEST_HAIR'
export const RECEIVE_HAIR = 'hair/RECEIVE_HAIR'

export function requestLeaders(jwt){
    return {
        type: REQUEST_LEADERS,
        jwt: jwt
    }
}

export function receiveLeaders(data){
    return {
        type: RECEIVE_LEADERS,
        data: data
    }
}

export function receiveNewHair(data){
    return {
        type: RECEIVE_NEW_HAIR,
        data: data
    }
}

export function receiveDelHair(data){
    return {
        type: RECEIVE_DEL_HAIR,
        data: data
    }
}

export function requestGetList(data, kind){
    return {
        type: REQUEST_LIST,
        data: data,
        kind: kind
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

export function requestHair(jwt, id, kind){
    return {
        type: REQUEST_HAIR,
        data: {
            jwt: jwt,
            id: id
        },
        kind: kind
    }
}

export function receiveHair(data){
    return {
        type: RECEIVE_HAIR,
        data: data
    }
}

export function addHair(jwt, form, kind){
    return {
        type: ADD_HAIR,
        data: {
            jwt: jwt,
            form: form
        },
        kind: kind
    }
}

