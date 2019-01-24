export const REQUEST_LIST = 'order/REQUEST_LIST';
export const REQUEST_LIST_KANBAN = 'order/REQUEST_LIST_KANBAN';
export const RECEIVE_LIST_KANBAN = 'order/RECEIVE_LIST_KANBAN';
export const RECEIVE_LIST = 'order/RECEIVE_LIST';
export const REQUEST_FILTER = 'order/REQUEST_FILTER';
export const REQUEST_FILTER_KANBAN = 'order/REQUEST_FILTER_KANBAN';
export const REQUEST_ADD = 'order/REQUEST_ADD';
export const RECEIVE_ADD_WORK_PROFILE = 'order/RECEIVE_ADD_WORK_PROFILE';
export const REQUEST_GET_PROCEDURES = 'order/REQUEST_GET_PROCEDURES';
export const RECEIVE_PROCEDURES = 'order/RECEIVE_PROCEDURES';
export const REQUEST_UPDATE_STATE = 'order/REQUEST_UPDATE_STATE';
export const RECEIVE_ORDER_KANBAN = 'order/RECEIVE_ORDER_KANBAN';
export const REQUEST_ORDER = 'order/REQUEST_ORDER';
export const RECEIVE_ORDER = 'order/RECEIVE_ORDER';
export const CHANGE_STATE = 'order/CHANGE_STATE';
export const EDIT_ORDER = 'order/EDIT_ORDER';
export const ADD_NEW_PAID = 'order/ADD_NEW_PAID';
export const REQUEST_UPDATE_ORDER = 'order/REQUEST_UPDATE_ORDER';
export const RECEIVE_UPDATE_ORDER = 'order/RECEIVE_UPDATE_ORDER';
export const REQUEST_ARCHIVE_ORDER = 'order/REQUEST_ARCHIVE_ORDER';
export const REQUEST_ORDER_STATS = 'order/REQUEST_ORDER_STATS';

export function requestGetList(jwt){
    return {
        type: REQUEST_LIST,
        jwt: jwt
    }
}

export function receiveList(data){
    return {
        type: RECEIVE_LIST,
        data: data
    }
}

export function receiveKanbanList(data){
    return {
        type: RECEIVE_LIST_KANBAN,
        data: data
    }
}

export function receiveAddWorkProfile(data){
    return {
        type: RECEIVE_ADD_WORK_PROFILE,
        data: data
    }
}

export function requestFilter(data){
    return {
        type: REQUEST_FILTER,
        data: data
    }
}

export function requestFilterKanban(data){
    return {
        type: REQUEST_FILTER_KANBAN,
        data: data
    }
}

export function requestAdd(data){
    return {
        type: REQUEST_ADD,
        data: data
    }
}

export function requestGetProcedures(){
    return {
        type: REQUEST_GET_PROCEDURES,
        data: {}
    }
}

export function receiveProcedures(data){
    return {
        type: RECEIVE_PROCEDURES,
        data: data
    }
}

export function requestGetListForKanban(data){
    return {
        type: REQUEST_LIST_KANBAN,
        data: data
    }
}

export function requestUpdateState(data){
    return {
        type: REQUEST_UPDATE_STATE,
        data: data
    }
}

export function receiveOrderKanban(data){
    return {
        type: RECEIVE_ORDER_KANBAN,
        data: data
    }
}

export function requestOrder(data){
    return {
        type: REQUEST_ORDER,
        data: data
    }
}

export function receiveOrder(data){
    return {
        type: RECEIVE_ORDER,
        data: data
    }
}

export function requestChangeOrderState(data){
    return {
        type: CHANGE_STATE,
        data: data
    }
}

export function editOrder(data){
    return {
        type: EDIT_ORDER,
        data: data
    }
}

export function requestAddNewPaidOrder(data){
    return {
        type: ADD_NEW_PAID,
        data: data
    }
}


export function requestUpdateOrder(data){
    return {
        type: REQUEST_UPDATE_ORDER,
        data: data
    }
}

export function receiveUpdateOrder(data){
    return {
        type: RECEIVE_UPDATE_ORDER,
        data: data
    }
}

export function requestArchiveOrder(id){
    return {
        type: REQUEST_ARCHIVE_ORDER,
        data: id
    }
}

