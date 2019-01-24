import { take, put, call, fork, select, cancelled, takeLatest } from "redux-saga/effects"
import Api from '../../api'
import {receiveListCustomers, REQUEST_FILTER, REQUEST_LIST} from "../../actions/report/customer";

function* watchRequestGetList() {
    yield takeLatest(REQUEST_LIST, requestListCustomer);
}

function* watchRequestFilter() {
    yield takeLatest(REQUEST_FILTER, requestFilter);
}

function* requestListCustomer(action){
    try{
        const response = yield call(
            Api.getCustomerListReport,
            action.jwt
        );
        const result = JSON.parse(response.text);
        yield put(receiveListCustomers(result));
    }catch(err){
        alert(err.message)
    }
}

function* requestFilter(action){
    try{
        const response = yield call(
            Api.getCustomerListReport,
            action.data.jwt,
            action.data.page,
            action.data.filters
        );
        const result = JSON.parse(response.text);
        yield put(receiveListCustomers(result));
    }catch(err){
        alert(err.message)
    }
}

export function* customerReport(){
    yield fork(watchRequestGetList);
    yield fork(watchRequestFilter);
}
