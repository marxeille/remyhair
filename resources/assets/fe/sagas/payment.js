import { take, put, call, fork, select, cancelled, takeLatest } from "redux-saga/effects"
import Api from '../api'
import {
    receiveList,
    REQUEST_FILTER,
    REQUEST_LIST,
     REQUEST_PAYMENT, receivePayment
} from "../actions/payment";

function* requestFilter(action){
    try{
        const response = yield call(
            Api.getPaymentList,
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
            Api.getPaymentList,
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

function* requestPayment(action){
    try{
        const response = yield call(
            Api.getPayment,
            action.data.jwt,
            action.data.id,
        );
        const result = JSON.parse(response.text);
        yield put(receivePayment(result.data));
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
//
// function* watchAddHair() {
//     yield takeLatest(ADD_HAIR, addHair);
// }

function* watchRequestPayment() {
    yield takeLatest(REQUEST_PAYMENT, requestPayment);
}

export function* payment(){
    yield fork(watchRequestGetList);
    yield fork(watchRequestFilter);
    // yield fork(watchAddHair);
    yield fork(watchRequestPayment);
}
