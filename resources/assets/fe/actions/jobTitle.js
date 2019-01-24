export const ADD_JOBTITLE = 'jobTitle/ADD_JOBTITLE';
export const RECEIVE_NEW_JOBTITLE = 'jobTitle/RECEIVE_NEW_JOBTITLE';
export const RECEIVE_DEL_JOBTITLE = 'jobTitle/RECEIVE_DEL_JOBTITLE';
export const REQUEST_LIST = 'jobTitle/REQUEST_LIST';
export const RECEIVE_LIST = 'jobTitle/RECEIVE_LIST';
export const REQUEST_FILTER = 'jobTitle/REQUEST_FILTER';
export const REQUEST_JOBTITLE = 'jobTitle/REQUEST_JOBTITLE';
export const RECEIVE_JOBTITLE = 'jobTitle/RECEIVE_JOBTITLE';

export function receiveNewJobTitle(data){
    return {
        type: RECEIVE_NEW_JOBTITLE,
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

export function requestJobTitle(jwt, id){
    return {
        type: REQUEST_JOBTITLE,
        data: {
            jwt: jwt,
            id: id
        },
    }
}

export function receiveJobTitle(data){
    return {
        type: RECEIVE_JOBTITLE,
        data: data
    }
}


