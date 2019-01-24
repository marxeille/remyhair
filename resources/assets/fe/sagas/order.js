import { take, put, call, fork, select, cancelled, takeLatest } from "redux-saga/effects"
import Api from '../api'
import {
    ADD_NEW_PAID,
    CHANGE_STATE,
    receiveList, receiveOrder, receiveOrderKanban, receiveProcedures,
    REQUEST_FILTER, REQUEST_FILTER_KANBAN,
    REQUEST_GET_PROCEDURES, EDIT_ORDER,
    REQUEST_LIST, REQUEST_LIST_KANBAN, REQUEST_ORDER, REQUEST_UPDATE_ORDER, REQUEST_UPDATE_STATE,
    receiveUpdateOrder, receiveKanbanList
} from "../actions/order";

function* watchRequestGetList() {
    yield takeLatest(REQUEST_LIST, requestList);
}

function* watchRequestEditOrder() {
    yield takeLatest(EDIT_ORDER, editOrder);
}

function* watchRequestFilter() {
    yield takeLatest(REQUEST_FILTER, requestFilter);
}

function* watchRequestFilterKanban() {
    yield takeLatest(REQUEST_FILTER_KANBAN, requestFilterKanban);
}

function* watchRequestGetProcedures() {
    yield takeLatest(REQUEST_GET_PROCEDURES, requestGetProcedures);
}

function* watchRequestGetListForKanban() {
    yield takeLatest(REQUEST_LIST_KANBAN, requestGetListForkanban);
}

function* watchRequestUpdateState() {
    yield takeLatest(REQUEST_UPDATE_STATE, requestUpdateState);
}

function* watchRequestOrder() {
    yield takeLatest(REQUEST_ORDER, requestOrder);
}

function* watchRequestChangeStateOrder() {
    yield takeLatest(CHANGE_STATE, requestChangeStateOrder);
}

function* watchRequestAddPaidOrder() {
    yield takeLatest(ADD_NEW_PAID, requestAddPaidOrder);
}

function* watchRequestUpdateOrder() {
    yield takeLatest(REQUEST_UPDATE_ORDER, requestUpdateOrder);
}

function* requestList(action){
    try{
        const response = yield call(
            Api.getOrderList,
            action.jwt
        );
        const result = JSON.parse(response.text);
        yield put(receiveList(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestFilter(action){
    try{
        const response = yield call(
            Api.getOrderList,
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

function* requestFilterKanban(action){
    try{
        const response = yield call(
            Api.getOrdersForKanban,
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

function* requestGetProcedures(action){
    try{
        const response = yield call(
            Api.getProcedures,
            action.data.jwt,
        );
        const result = JSON.parse(response.text);
        yield put(receiveProcedures(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestGetListForkanban(action){
    try{
        const response = yield call(
            Api.getOrdersForKanban,
            action.data.jwt,
            action.data.filter
        );
        const result = JSON.parse(response.text);
        yield put(receiveKanbanList(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestUpdateState(action){
    try{
        const response = yield call(
            Api.updateOrderState,
            action.data.jwt,
            action.data.orders,
        );
        const result = JSON.parse(response.text);
        yield put(receiveOrderKanban(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestOrder(action){
    try{
        const response = yield call(
            Api.requestOrder,
            action.data.jwt,
            action.data.id,
        );
        const result = JSON.parse(response.text);
        yield put(receiveOrder(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* editOrder(action){
    try{
        const response = yield call(
            Api.editOrder,
            action.data.jwt,
            action.data,
        );
        const result = JSON.parse(response.text);
        yield put(receiveOrder(result.data.order));
    }catch(err){
        alert(err.message)
    }
}

function* requestChangeStateOrder(action){
    try{
        const response = yield call(
            Api.requestChangeStateOrder,
            action.data.jwt,
            action.data.order,
        );
        const result = JSON.parse(response.text);
        yield put(receiveOrder(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestAddPaidOrder(action){
    try{
        const response = yield call(
            Api.requestAddPaidOrder,
            action.data.jwt,
            action.data.order,
        );
        const result = JSON.parse(response.text);
        yield put(receiveOrder(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestUpdateOrder(action){
    try{
        const response = yield call(
            Api.requestUpdateOrder,
            action.data.jwt,
            action.data.update,
        );
        const result = JSON.parse(response.text);
        yield put(receiveUpdateOrder(result.data));
    }catch(err){
        alert(err.message)
    }
}

export function* order(){
    yield fork(watchRequestGetList);
    yield fork(watchRequestEditOrder);
    yield fork(watchRequestFilter);
    yield fork(watchRequestFilterKanban);
    yield fork(watchRequestGetProcedures);
    yield fork(watchRequestGetListForKanban);
    yield fork(watchRequestUpdateState);
    yield fork(watchRequestOrder);
    yield fork(watchRequestChangeStateOrder);
    yield fork(watchRequestAddPaidOrder);
    yield fork(watchRequestUpdateOrder);
}
