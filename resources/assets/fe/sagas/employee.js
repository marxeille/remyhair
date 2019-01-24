import { take, put, call, fork, select, cancelled, takeLatest } from "redux-saga/effects"
import Api from '../api'
import {
    ADD_EMPLOYEE, receiveEmployee,
    receiveLeaders,
    receiveList,
    receiveListCustomer,
    receiveNewEmployee, REQUEST_EMPLOYEE, REQUEST_FILTER,
    REQUEST_LEADERS,
    REQUEST_LIST,
    REQUEST_FILTER_CUSTOMER,
    REQUEST_LIST_CUSTOMER, REQUEST_LIST_SUPPORT,REQUEST_FILTER_SUPPORT, receiveListSupport
} from "../actions/employee";
function* watchRequestLeaders() {
    yield takeLatest(REQUEST_LEADERS, requestLeaders);
}

function* watchRequestFilter() {
    yield takeLatest(REQUEST_FILTER, requestFilter);
}

function* watchRequestFilterListCustomer() {
    yield takeLatest(REQUEST_FILTER_CUSTOMER, requestFilterListCustomer);
}

function* watchRequestGetList() {
    yield takeLatest(REQUEST_LIST, requestList);
}

function* watchRequestGetListCustomer() {
    yield takeLatest(REQUEST_LIST_CUSTOMER, requestListCustomer);
}

function* watchRequestGetListSupport() {
    yield takeLatest(REQUEST_LIST_SUPPORT, requestListSupport);
}

function* watchAddEmployee() {
    yield takeLatest(ADD_EMPLOYEE, addEmployee);
}

function* watchRequestEmployee() {
    yield takeLatest(REQUEST_EMPLOYEE, requestEmployee);
}

function* watchRequestFilterListSupport() {
    yield takeLatest(REQUEST_FILTER_SUPPORT, requestFilterListSupport);
}

function* requestLeaders(action){
    try{
        const response = yield call(
            Api.getLeaders,
            action.jwt
        );
        const result = JSON.parse(response.text);
        yield put(receiveLeaders(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestFilter(action){
    try{
        const response = yield call(
            Api.getEmployeeList,
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

function* requestFilterListCustomer(action){
    try{
        const response = yield call(
            Api.getCustomerListByEmployee,
            action.data.jwt,
            action.data.id_employee,
            action.data.page,
            action.data.filters
        );
        const result = JSON.parse(response.text);
        yield put(receiveListCustomer(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestFilterListSupport(action){
    try{
        const response = yield call(
            Api.getSupportListByEmployee,
            action.data.jwt,
            action.data.id_employee,
            action.data.page,
            action.data.filters
        );
        const result = JSON.parse(response.text);
        yield put(receiveListSupport(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestListSupport(action){
    try{
        const response = yield call(
            Api.getSupportListByEmployee,
            action.jwt,
            action.data.id,
            action.data.page,
            action.data.filters
        );
        const result = JSON.parse(response.text);
        yield put(receiveListSupport(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestList(action){
    try{
        const response = yield call(
            Api.getEmployeeList,
            action.jwt,
            action.data
        );
        const result = JSON.parse(response.text);
        yield put(receiveList(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestListCustomer(action){
    try{
        const response = yield call(
            Api.getCustomerListByEmployee,
            action.jwt,
            action.data.id
        );
        const result = JSON.parse(response.text);
        yield put(receiveListCustomer(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* addEmployee(action){
    try{
        const response = yield call(
            Api.addEmployee,
            action.jwt,
            action.form,
        );
        const result = JSON.parse(response.text);
        yield put(receiveNewEmployee(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestEmployee(action){
    try{
        const response = yield call(
            Api.getEmployee,
            action.jwt,
            action.data.id,
        );
        const result = JSON.parse(response.text);
        yield put(receiveEmployee(result.data));
    }catch(err){
        alert(err.message)
    }
}

export function* employee(){
    yield fork(watchRequestGetList);
    yield fork(watchRequestGetListCustomer);
    yield fork(watchRequestGetListSupport);
    yield fork(watchRequestLeaders);
    yield fork(watchAddEmployee);
    yield fork(watchRequestFilter);
    yield fork(watchRequestFilterListCustomer);
    yield fork(watchRequestFilterListSupport);
    yield fork(watchRequestEmployee);
}
