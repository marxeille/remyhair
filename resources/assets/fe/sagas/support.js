import { take, put, call, fork, select, cancelled, takeLatest } from "redux-saga/effects"
import Api from '../api'
import {receiveList, REQUEST_FILTER, REQUEST_LIST} from "../actions/support";

function* watchRequestGetList() {
    yield takeLatest(REQUEST_LIST, requestList);
}

function* watchRequestFilter() {
    yield takeLatest(REQUEST_FILTER, requestFilter);
}

function* requestList(action){
    try{
        const response = yield call(
            Api.getSupportList,
            action.jwt
        );
        const result = JSON.parse(response.text);
        yield put(receiveList(result));
    }catch(err){
        alert(err.message)
    }
}

function* requestFilter(action){
    try{
        const response = yield call(
            Api.getSupportList,
            action.data.jwt,
            action.data.page,
            action.data.filters
        );
        const result = JSON.parse(response.text);
        yield put(receiveList(result));
    }catch(err){
        alert(err.message)
    }
}

export function* support(){
    yield fork(watchRequestGetList);
    yield fork(watchRequestFilter);
}
