import { take, put, call, fork, select, cancelled, takeLatest } from "redux-saga/effects"
import Api from '../api'
import {
    receiveList,
    REQUEST_FILTER,
    REQUEST_LIST,
    ADD_HAIR,
    REQUEST_HAIR,
    receiveHair
} from "../actions/hair";

function* requestFilter(action){
    try{
        const response = yield call(
            Api.getHairList,
            action.data.jwt,
            action.data.page,
            action.data.filters,
            action.data.kind,
        );
        const result = JSON.parse(response.text);
        yield put(receiveList(result));
    }catch(err){
        alert(err.message)
    }
}

function* requestList(action){
    try{
        const response = yield call(
            Api.getHairList,
            action.data.jwt,
            action.data.page,
            action.data.filters,
            action.kind,
        );
        const result = JSON.parse(response.text);
        yield put(receiveList(result));
    }catch(err){
        alert(err.message)
    }
}
function* addHair(action){
    try{
        const response = yield call(
            Api.addHair,
            action.jwt,
            action.form,
            action.kind,
        );
        const result = JSON.parse(response.text);
        yield put(receiveNewHair(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestHair(action){
    try{
        const response = yield call(
            Api.getHair,
            action.data.jwt,
            action.data.id,
            action.kind,
        );
        const result = JSON.parse(response.text);
        yield put(receiveHair(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* watchRequestFilter() {
    yield takeLatest(REQUEST_FILTER, requestFilter);
}

function* watchRequestGetList() {
    yield takeLatest(REQUEST_LIST, requestList);
}

function* watchAddHair() {
    yield takeLatest(ADD_HAIR, addHair);
}

function* watchRequestHair() {
    yield takeLatest(REQUEST_HAIR, requestHair);
}

export function* hair(){
    yield fork(watchRequestGetList);
    yield fork(watchRequestFilter);
    yield fork(watchAddHair);
    yield fork(watchRequestHair);
}
