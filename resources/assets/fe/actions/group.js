export const ADD_GROUP = 'group/ADD_GROUP';
export const RECEIVE_ADD_GROUP = 'group/RECEIVE_ADD_GROUP';
export const GET_ALL_GROUPS = 'group/GET_ALL_GROUPS';
export const RECEIVE_GROUPS = 'group/RECEIVE_GROUPS';

export function addGroup(jwt, data){
    return {
        type: ADD_GROUP,
        jwt: jwt,
        data: data
    }
}

export function receiveAddGroup(data){
    return {
        type: RECEIVE_ADD_GROUP,
        data: data
    }
}

export function getAll(jwt){
    return {
        type: GET_ALL_GROUPS,
        data: jwt
    }
}

export function receiveGroups(data){
    return {
        type: RECEIVE_GROUPS,
        data: data
    }
}



