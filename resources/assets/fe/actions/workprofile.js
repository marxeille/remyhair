export const REQUEST_LIST = 'workprofile/REQUEST_LIST';
export const REQUEST_LIST_KANBAN = 'workprofile/REQUEST_LIST_KANBAN';
export const RECEIVE_LIST = 'workprofile/RECEIVE_LIST';
export const REQUEST_FILTER = 'workprofile/REQUEST_FILTER';
export const REQUEST_FILTER_KANBAN = 'workprofile/REQUEST_FILTER_KANBAN';
export const REQUEST_ADD = 'workprofile/REQUEST_ADD';
export const RECEIVE_ADD_WORK_PROFILE = 'workprofile/RECEIVE_ADD_WORK_PROFILE';
export const REQUEST_GET_PROCEDURES = 'workprofile/REQUEST_GET_PROCEDURES';
export const RECEIVE_PROCEDURES = 'workprofile/RECEIVE_PROCEDURES';
export const REQUEST_UPDATE_STATE = 'workprofile/REQUEST_UPDATE_STATE';
export const RECEIVE_WORKPROFILE_KANBAN = 'workprofile/RECEIVE_WORKPROFILE_KANBAN';
export const REQUEST_REMOVE_STEP = 'workprofile/REQUEST_REMOVE_STEP';
export const SEND_EMAIL = 'workprofile/sendEmail';
export const SEND_EMAIL_WHEN_CHANGE_STATUS = 'workprofile/sendEmailWhenChangeStatus';
export const ADD_LEADER_SUGGESSTION = 'workprofile/ADD_LEADER_SUGGESSTION';
export const RECEIVE_LEADER_SUGGESSTION = 'workprofile/RECEIVE_LEADER_SUGGESSTION';
export const RECEIVE_ARCHIVE_WORKPROFILE = 'workprofile/RECEIVE_ARCHIVE_WORKPROFILE';
export const RECEIVE_KANBAN_LIST = 'workprofile/RECEIVE_KANBAN_LIST';

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

export function receivekanbanList(data){
    return {
        type: RECEIVE_KANBAN_LIST,
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

export function receiveWorkProfileKanban(data){
    return {
        type: RECEIVE_WORKPROFILE_KANBAN,
        data: data
    }
}

export function requestRemoveStep(data){
    return {
        type: REQUEST_REMOVE_STEP,
        data: data
    }
}

export function sendEmail(data){
    return {
        type: SEND_EMAIL,
        data: data
    }
}

export function sendEmailWhenChangeStatus(data){
    return {
        type: SEND_EMAIL_WHEN_CHANGE_STATUS,
        data: data
    }
}

export function addLeaderSuggesstion(data){
    return {
        type: ADD_LEADER_SUGGESSTION,
        data: data
    }
}

export function receiveLeaderSuggesstion(data){
    return {
        type: RECEIVE_LEADER_SUGGESSTION,
        data: data
    }
}

export function requestArchiveWorkProfile(id){
    return {
        type: RECEIVE_ARCHIVE_WORKPROFILE,
        data: id
    }
}



