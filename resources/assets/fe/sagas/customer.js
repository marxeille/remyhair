import { take, put, call, fork, select, cancelled, takeLatest } from "redux-saga/effects"
import Api from '../api'
import {
    receiveList, receiveUnSupportList,
    REQUEST_FILTER, REQUEST_FILTER_UNSUPPORT,
    REQUEST_LIST,
    REQUEST_SEARCH_CUSTOMER,
    REQUEST_IMPORT_CUSTOMERS,
    REQUEST_UNSUPPORT_LIST,
    REQUEST_DELETE_CUSTOMER,
    receiveDeleteCustomer
} from "../actions/customer";
import {isCallbackFunction} from "../utility";

function* watchRequestGetList() {
    yield takeLatest(REQUEST_LIST, requestList);
}

function* watchImportCustomers() {
    yield takeLatest(REQUEST_IMPORT_CUSTOMERS, requestImportCustomers);
}

function* watchRequestGetListUnSupport() {
    yield takeLatest(REQUEST_UNSUPPORT_LIST, requestListUnSupport);
}

function* watchRequestFilterUnSupport() {
    yield takeLatest(REQUEST_FILTER_UNSUPPORT, requestFilterUnSupport);
}

function* watchRequestFilter() {
    yield takeLatest(REQUEST_FILTER, requestFilter);
}

function* watchRequestSearch() {
    yield takeLatest(REQUEST_SEARCH_CUSTOMER, requestSearch);
}

function* watchRequestDeleteCustomer() {
    yield takeLatest(REQUEST_DELETE_CUSTOMER, requestDelete);
}

function* requestList(action){
    try{
        const response = yield call(
            Api.getCustomerList,
            action.jwt
        );
        const result = JSON.parse(response.text);
        yield put(receiveList(result));
    }catch(err){
        alert(err.message)
    }
}

function* requestListUnSupport(action){
    try{
        const response = yield call(
            Api.getCustomerUnSupportList,
            action.jwt
        );
        const result = JSON.parse(response.text);
        yield put(receiveUnSupportList(result));
    }catch(err){
        alert(err.message)
    }
}

function* requestFilter(action){
    try{
        const response = yield call(
            Api.getCustomerList,
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

function* requestFilterUnSupport(action){
    try{
        const response = yield call(
            Api.getCustomerUnSupportList,
            action.data.jwt,
            action.data.page,
            action.data.filters
        );
        const result = JSON.parse(response.text);
        yield put(receiveUnSupportList(result));
    }catch(err){
        alert(err.message)
    }
}

function* requestSearch(action){
    try{
        const response = yield call(
            Api.searchCustomer,
            action.data.jwt,
            action.data.key,
        );
        const result = JSON.parse(response.text);
            isCallbackFunction(action.data.onSuccess) ? action.data.onSuccess(result.data.customer) : null
    }catch(err){
        alert(err.message)
    }
}

function* requestImportCustomers(action){
    try{
        const response = yield call(
            Api.importCustomers,
            action.data.jwt,
            action.data.data,
        );
        const result = JSON.parse(response.text);
        if(result.status){
            isCallbackFunction(action.data.onSuccess) ? action.data.onSuccess(result.data) : null
        }else{
            isCallbackFunction(action.data.onError) ? action.data.onError(result.data) : null
        }
    }catch(err){
        alert(err.message)
    }
}

function* requestDelete(action){
    try{
        const response = yield call(
            Api.deleteCustomer,
            action.data.jwt,
            action.data.id,
        );
        const result = JSON.parse(response.text);
        if(result.status){
            yield put(receiveDeleteCustomer(action.data.id));
        }else{
            alert('something went wrong')
        }
    }catch(err){
        alert(err.message)
    }
}

export function* customer(){
    yield fork(watchRequestGetList);
    yield fork(watchRequestGetListUnSupport);
    yield fork(watchRequestDeleteCustomer);
    yield fork(watchRequestFilter);
    yield fork(watchImportCustomers);
    yield fork(watchRequestFilterUnSupport);
    yield fork(watchRequestSearch);
}
