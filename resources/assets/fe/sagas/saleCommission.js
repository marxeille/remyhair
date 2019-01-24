import { take, put, call, fork, select, cancelled, takeLatest } from "redux-saga/effects"
import Api from '../api'
import {receiveDetailList, receiveList, REQUEST_DETAIL_FILTER, REQUEST_DETAIL_LIST} from "../actions/saleCommission";
export const REQUEST_LIST = 'saleCommission/REQUEST_LIST';
export const RECEIVE_LIST = 'saleCommission/RECEIVE_LIST';
export const REQUEST_FILTER = 'saleCommission/REQUEST_FILTER';

function* watchRequestGetList() {
    yield takeLatest(REQUEST_LIST, requestList);
}

function* watchRequestGetDetailList() {
    yield takeLatest(REQUEST_DETAIL_LIST, requestDetailList);
}

function* watchRequestFilter() {
    yield takeLatest(REQUEST_FILTER, requestFilter);
}

function* watchRequestDetailFilter() {
    yield takeLatest(REQUEST_DETAIL_FILTER, requestDetailFilter);
}

function* requestList(action) {
    try {
        const response = yield call(
            Api.getSaleCommissionList,
            action.jwt,
            action.data
        );
        const result = JSON.parse(response.text);
        yield put(receiveList(result));
    } catch (err) {
        alert(err.message)
    }

}

function* requestDetailList(action) {
    try {
        const response = yield call(
            Api.getDetailSaleCommissionList,
            action.jwt,
            action.id
        );
        const result = JSON.parse(response.text);
        yield put(receiveDetailList(result));
    } catch (err) {
        alert(err.message)
    }

}


function* requestFilter(action){
    try{
        const response = yield call(
            Api.getSaleCommissionList,
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

function* requestDetailFilter(action){
    try{
        const response = yield call(
            Api.getDetailSaleCommissionList,
            action.data.jwt,
            action.data.id,
            action.data.page,
            action.data.filters
        );
        const result = JSON.parse(response.text);
        yield put(receiveDetailList(result));
    }catch(err){
        alert(err.message)
    }
}


export function* saleCommission(){
    yield fork(watchRequestGetList);
    yield fork(watchRequestGetDetailList);
    yield fork(watchRequestDetailFilter);
}
