import { take, put, call, fork, select, cancelled, takeLatest } from "redux-saga/effects"
import Api from '../api'
import {
    receiveList,
    REQUEST_FILTER,
    REQUEST_LIST,
     REQUEST_JOBTITLE, receiveJobTitle
} from "../actions/jobTitle";

function* requestFilter(action){
    try{
        const response = yield call(
            Api.getJobTitleList,
            action.data.jwt,
            action.data.page,
            action.data.filters,
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
            Api.getJobTitleList,
            action.data.jwt,
            action.data.page,
            action.data.filters,
        );
        const result = JSON.parse(response.text);
        yield put(receiveList(result));
    }catch(err){
        alert(err.message)
    }
}

function* requestJobTitle(action){
    try{
        const response = yield call(
            Api.getJobTitle,
            action.data.jwt,
            action.data.id,
        );
        const result = JSON.parse(response.text);
        yield put(receiveJobTitle(result.data));
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

function* watchRequestPayment() {
    yield takeLatest(REQUEST_JOBTITLE, requestJobTitle);
}

export function* jobTitle(){
    yield fork(watchRequestGetList);
    yield fork(watchRequestFilter);
    yield fork(watchRequestPayment);
}
