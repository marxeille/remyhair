import { take, put, call, fork, select, cancelled, takeLatest } from "redux-saga/effects"
import Api from '../api'
import {
    receiveList,
    receiveProcedures,
    receiveWorkProfileKanban,
    REQUEST_FILTER,
    REQUEST_FILTER_KANBAN,
    REQUEST_GET_PROCEDURES,
    REQUEST_LIST,
    REQUEST_LIST_KANBAN,
    ADD_LEADER_SUGGESSTION,
    REQUEST_REMOVE_STEP,
    REQUEST_UPDATE_STATE,
    SEND_EMAIL,
    SEND_EMAIL_WHEN_CHANGE_STATUS,
    sendEmailWhenChangeStatus,
    receiveLeaderSuggesstion,
    receivekanbanList
} from "../actions/workprofile";

function* watchRequestGetList() {
    yield takeLatest(REQUEST_LIST, requestList);
}

function* watchRequestFilter() {
    yield takeLatest(REQUEST_FILTER, requestFilter);
}

function* watchRequestFilterKanban() {
    yield takeLatest(REQUEST_FILTER_KANBAN, requestFilterKanban);
}

function* watchRequestGetProcedures() {
    yield takeLatest(REQUEST_GET_PROCEDURES, requestGetProcedures);
}

function* watchRequestGetListForKanban() {
    yield takeLatest(REQUEST_LIST_KANBAN, requestGetListForkanban);
}

function* watchRequestUpdateState() {
    yield takeLatest(REQUEST_UPDATE_STATE, requestUpdateState);
}

function* watchSendEmail() {
    yield takeLatest(SEND_EMAIL, sendEmail);
}

function* watchSendEmailWhenChangeStatus() {
    yield takeLatest(SEND_EMAIL_WHEN_CHANGE_STATUS, sendEmailChangeStatus);
}

function* watchAddLeaderSuggsstion() {
    yield takeLatest(ADD_LEADER_SUGGESSTION, addLeaderSuggesstion);
}

function* sendEmailChangeStatus(action){
    try{
        yield call(
            Api.sendEmailChangeStatus,
            action.data
        );
    }catch(err){
        alert(err.message)
    }
}

function* sendEmail(action){
    try{
        const response = yield call(
            Api.sendEmail,
            action.data
        );
    }catch(err){
        alert(err.message)
    }
}

function* requestList(action){
    try{
        const response = yield call(
            Api.getWorkProfileList,
            action.jwt
        );
        const result = JSON.parse(response.text);
        yield put(receiveList(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestFilter(action){
    try{
        const response = yield call(
            Api.getWorkProfileList,
            action.data.jwt,
            action.data.page,
            action.data.filters
        );
        const result = JSON.parse(response.text);
        yield put(receiveList(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestFilterKanban(action){
    try{
        const response = yield call(
            Api.getWorkProfilesForKanban,
            action.data.jwt,
            action.data.page,
            action.data.filters
        );
        const result = JSON.parse(response.text);
        yield put(receiveList(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestGetProcedures(action){
    try{
        const response = yield call(
            Api.getProcedures,
            action.data.jwt,
        );
        const result = JSON.parse(response.text);
        yield put(receiveProcedures(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestGetListForkanban(action){
    try{
        const response = yield call(
            Api.getWorkProfilesForKanban,
            action.data.jwt,
            action.data.filter
        );
        const result = JSON.parse(response.text);
        yield put(receivekanbanList(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestUpdateState(action) {
    try {
        const response = yield call(
            Api.updateWorkProfileState,
            action.data.jwt,
            action.data.workProfiles,
        );
        const result = JSON.parse(response.text);
    } catch (err) {
        alert(err.message)
    }
}


function* addLeaderSuggesstion(action) {
    try {
        const response = yield call(
            Api.addLeaderSuggesstion,
            action.data.jwt,
            action.data.id,
            action.data.suggesstion,
        );
        const result = JSON.parse(response.text);
        yield put(receiveLeaderSuggesstion(result.data))
    } catch (err) {
        alert(err.message)
    }
}


function* addLeaderSuggesstion(action) {
    try {
        const response = yield call(
            Api.addLeaderSuggesstion,
            action.data.jwt,
            action.data.id,
            action.data.suggesstion,
        );
        const result = JSON.parse(response.text);
        yield put(receiveLeaderSuggesstion(result.data))
    } catch (err) {
        alert(err.message)
    }
}


export function* workProfile(){
    yield fork(watchRequestGetList);
    yield fork(watchRequestFilter);
    yield fork(watchRequestFilterKanban);
    yield fork(watchRequestGetProcedures);
    yield fork(watchRequestGetListForKanban);
    yield fork(watchRequestUpdateState);
    yield fork(watchSendEmail);
    yield fork(watchSendEmailWhenChangeStatus);
    yield fork(watchAddLeaderSuggsstion);
}
