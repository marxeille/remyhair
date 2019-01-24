import { take, put, call, fork, select, cancelled, takeLatest } from "redux-saga/effects"
import Api from '../api'
import {
    receiveList,
    REQUEST_FILTER,
    REQUEST_LIST
} from "../actions/history";

function* requestFilter(action){
    try{
        const response = yield call(
            Api.getHistoryList,
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

function* requestList(action){
    try{
        const response = yield call(
            Api.getHistoryList,
            action.jwt,
            action.data
        );
        const result = JSON.parse(response.text);
        yield put(receiveList(result));
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

export function* history(){
    yield fork(watchRequestGetList);
    yield fork(watchRequestFilter);
}
