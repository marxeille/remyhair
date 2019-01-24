import { take, put, call, fork, select, cancelled, takeLatest } from "redux-saga/effects"
import Api from '../api'
import {
    receiveInvoice,
    receiveList,
    REQUEST_FILTER, REQUEST_INVOICE,
    REQUEST_LIST,
} from "../actions/invoice";

function* requestFilter(action){
    try{
        const response = yield call(
            Api.getInvoiceList,
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
            Api.getInvoiceList,
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

function* requestInvoice(action){
    try{
        const response = yield call(
            Api.getInvoice,
            action.data.jwt,
            action.data.id,
        );
        const result = JSON.parse(response.text);
        yield put(receiveInvoice(result.data));
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

function* watchRequestInvoice() {
    yield takeLatest(REQUEST_INVOICE, requestInvoice);
}

export function* invoice(){
    yield fork(watchRequestGetList);
    yield fork(watchRequestFilter);
    yield fork(watchRequestInvoice);
}
