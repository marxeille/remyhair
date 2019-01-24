import { take, put, call, fork, select, cancelled, takeLatest } from "redux-saga/effects"
import Api from '../../api'
import {
    REQUEST_ORDER_FILTER,
    REQUEST_ORDER_STATS,
    receiveOrderStats,
    REQUEST_ORDER_SUMMARY,
    receiveOrderSummary,
    REQUEST_ORDER_WEFT,
    receiveGetOrderWeft,
    receiveOrderClosure,
    REQUEST_ORDER_CLOSURE,
    REQUEST_REPORT_TYPE,
    receiveReportType,
    REQUEST_REPORT_SIZE,
    receiveReportSize,
    REQUEST_REPORT_COUNTRY,
    receiveReportCountry,
    REQUEST_REPORT_CUSTOMER,
    receiveReportCustomer,
    receiveReportPayment,
    REQUEST_REPORT_CUSTOMER_BALANCE, receiveReportCustomerBalance, REQUEST_REPORT_PAYMENT
} from "../../actions/report/order";

function* watchRequestOrderStats() {
    yield takeLatest(REQUEST_ORDER_STATS, requestOrderStats);
}

function* watchRequestOrderClosure() {
    yield takeLatest(REQUEST_ORDER_CLOSURE, requestOrderCLosure);
}

function* watchRequestFilter() {
    yield takeLatest(REQUEST_ORDER_FILTER, requestOrderFilter);
}

function* watchRequestOrderWeft() {
    yield takeLatest(REQUEST_ORDER_WEFT, requestOrderWeft);
}

function* watchRequestOrderSummary() {
    yield takeLatest(REQUEST_ORDER_SUMMARY, requestOrderSummary);
}

function* watchRequestReportType() {
    yield takeLatest(REQUEST_REPORT_TYPE, requestReportType);
}

function* watchRequestReportSize() {
    yield takeLatest(REQUEST_REPORT_SIZE, requestReportSize);
}

function* watchRequestReportCountry() {
    yield takeLatest(REQUEST_REPORT_COUNTRY, requestReportCountry);
}

function* watchRequestReportCustomer() {
    yield takeLatest(REQUEST_REPORT_CUSTOMER, requestReportCustomer);
}

function* watchRequestReportCustomerBalance() {
    yield takeLatest(REQUEST_REPORT_CUSTOMER_BALANCE, requestReportCustomerBalance);
}

function* watchRequestReportPayment() {
    yield takeLatest(REQUEST_REPORT_PAYMENT, requestReportOrderPayment);
}

function* requestOrderStats(action){
    try{
        const response = yield call(
            Api.getOrderListReport,
            action.data.jwt,
            'stats',
            action.data.filters,
            action.data.dateShip
        );
        const result = JSON.parse(response.text);
        yield put(receiveOrderStats(result));
    }catch(err){
        alert(err.message)
    }
}

function* requestOrderSummary(action){
    try{
        const response = yield call(
            Api.getOrderListReport,
            action.data.jwt,
            'summary',
            action.data.filters,
            action.data.dateShip
        );
        const result = JSON.parse(response.text);
        yield put(receiveOrderSummary(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestOrderWeft(action){
    try{
        const response = yield call(
            Api.getOrderListReport,
            action.data.jwt,
            'weft',
            action.data.filters,
            action.data.dateShip
        );
        const result = JSON.parse(response.text);
        yield put(receiveGetOrderWeft(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestOrderCLosure(action){
    try{
        const response = yield call(
            Api.getOrderListReport,
            action.data.jwt,
            'closure',
            action.data.filters,
            action.data.dateShip
        );
        const result = JSON.parse(response.text);
        yield put(receiveOrderClosure(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestOrderFilter(action){
    try{
        const response = yield call(
            Api.getOrderListReport,
            action.data.jwt,
            action.data.page,
            action.data.filters,
            action.data.dateShip
        );
        const result = JSON.parse(response.text);
        yield put(receiveListOrders(result));
    }catch(err){
        alert(err.message)
    }
}

function* requestReportCustomer(action){
    try{
        const response = yield call(
            Api.getOrderListReport,
            action.data.jwt,
            'customer',
            action.data.filters,
            action.data.dateShip
        );
        const result = JSON.parse(response.text);
        yield put(receiveReportCustomer(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestReportType(action){
    try{
        const response = yield call(
            Api.getOrderListReport,
            action.data.jwt,
            'product-type',
            action.data.filters,
            action.data.dateShip
        );
        const result = JSON.parse(response.text);
        yield put(receiveReportType(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestReportSize(action){
    try{
        const response = yield call(
            Api.getOrderListReport,
            action.data.jwt,
            'product-size',
            action.data.filters,
            action.data.dateShip
        );
        const result = JSON.parse(response.text);
        yield put(receiveReportSize(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestReportCountry(action){
    try{
        const response = yield call(
            Api.getOrderListReport,
            action.data.jwt,
            'country',
            action.data.filters,
            action.data.dateShip
        );
        const result = JSON.parse(response.text);
        yield put(receiveReportCountry(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestReportCustomerBalance(action){
    try{
        const response = yield call(
            Api.getOrderListReport,
            action.data.jwt,
            'customer-balance',
            action.data.filters,
            action.data.dateShip
        );
        const result = JSON.parse(response.text);
        yield put(receiveReportCustomerBalance(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* requestReportOrderPayment(action){
    try{
        const response = yield call(
            Api.getOrderListReport,
            action.data.jwt,
            'payment',
            action.data.filters,
            action.data.dateShip
        );
        const result = JSON.parse(response.text);
        yield put(receiveReportPayment(result.data));
    }catch(err){
        alert(err.message)
    }
}

export function* orderReport(){
    yield fork(watchRequestOrderStats);
    yield fork(watchRequestOrderSummary);
    yield fork(watchRequestOrderWeft);
    yield fork(watchRequestOrderClosure);
    yield fork(watchRequestFilter);
    yield fork(watchRequestReportType);
    yield fork(watchRequestReportSize);
    yield fork(watchRequestReportCountry);
    yield fork(watchRequestReportCustomer);
    yield fork(watchRequestReportCustomerBalance);
    yield fork(watchRequestReportPayment);
}
