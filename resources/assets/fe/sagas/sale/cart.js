import { take, put, call, fork, select, cancelled, takeLatest } from "redux-saga/effects"
import {
    assignAddress,
    updateCart,
    assignCustomer, CLEAR_ADDRESS, CLEAR_CUSTOMER,
    receiveInitCart,
    REQUEST_INIT_CART, REQUEST_UPDATE_ADDRESS, REQUEST_UPDATE_CUSTOMER,
    UPDATE_CARRIER,
    UPDATE_DISCOUNT,
    UPDATE_SHIPPING_COST,
    ADD_ADDRESS, COMPLETE_ORDER, receiveOrder, CANCEL_ORDER, UPDATE_SALEMAN, UPDATE_PAYMENT_FEE
} from "../../actions/order/cart";
import Api from '../../api'
import {isCallbackFunction} from "../../utility";

function* watchRequestInitCart() {
    yield takeLatest(REQUEST_INIT_CART, requestInitCart);
}

function* watchUpdateShippingCost() {
    yield takeLatest(UPDATE_SHIPPING_COST, updateShippingCost);
}

function* watchUpdateCarrier() {
    yield takeLatest(UPDATE_CARRIER, updateCarrier);

}

function* watchUpdateDiscount() {
    yield takeLatest(UPDATE_DISCOUNT, updateDiscount);
}

function* watchRequestUpdateCustomer() {
    yield takeLatest(REQUEST_UPDATE_CUSTOMER, requestUpdateCustomer);
}

function* watchRequestUpdateAddress() {
    yield takeLatest(REQUEST_UPDATE_ADDRESS, requestUpdateAddress);
}

function* watchClearCustomer() {
    yield takeLatest(CLEAR_CUSTOMER, clearCustomer);
}

function* watchClearAddress() {
    yield takeLatest(CLEAR_ADDRESS, clearAddress);
}

function* watchAddAddress() {
    yield takeLatest(ADD_ADDRESS, addAddress);
}

function* watchCompleteOrder() {
    yield takeLatest(COMPLETE_ORDER, completeOrder);
}

function* watchCancelOrder() {
    yield takeLatest(CANCEL_ORDER, cancelOrder);
}

function* watchUpdateSaleman() {
    yield takeLatest(UPDATE_SALEMAN, updateSaleman);
}

function* watchUpdatePaymentFee() {
    yield takeLatest(UPDATE_PAYMENT_FEE, updatePaymentFee);
}

function* requestInitCart(action){
    try{
        const response = yield call(
            Api.requestInitCart,
            action.jwt
        );
        const result = JSON.parse(response.text);
        if(result.data.balance == undefined){
            result.data.cart.balance = localStorage.getItem('cartCustomerBalance') != null && parseFloat(localStorage.getItem('cartCustomerBalance')) <= result.data.cart.summary.customer_balance ? localStorage.getItem('cartCustomerBalance') : result.data.cart.summary.customer_balance
        }
        yield put(receiveInitCart(result.data));
    }catch(err){
        alert(err.message)
    }
}

function* updateShippingCost(action){
    try{
        const response = yield call(
            Api.updateShippingCost,
            action.data.jwt,
            action.data.data
        );
        const result = JSON.parse(response.text);
        yield put(receiveInitCart(result.data, action.isEditing));
    }catch(err){
        alert(err.message)
    }
}

function* updateCarrier(action){
    try{
        const response = yield call(
            Api.updateCarrier,
            action.data.jwt,
            action.data.data
        );
        const result = JSON.parse(response.text);
        yield put(receiveInitCart(result.data , action.isEditing));
    }catch(err){
        alert(err.message)
    }
}

function* updateSaleman(action){
    try{
        const response = yield call(
            Api.updateSaleman,
            action.data.jwt,
            action.data.cart
        );
        const result = JSON.parse(response.text);
        yield put(receiveInitCart(result.data , action.isEditing));
    }catch(err){
        alert(err.message)
    }
}

function* updateDiscount(action){
    try{
        const response = yield call(
            Api.updateDiscount,
            action.data.jwt,
            action.data.data
        );
        const result = JSON.parse(response.text);
        yield put(receiveInitCart(result.data, action.isEditing));
    }catch(err){
        alert(err.message)
    }
}

function* updatePaymentFee(action){
    try{
        const response = yield call(
            Api.updatePaymentFee,
            action.data.jwt,
            action.data.data
        );
        const result = JSON.parse(response.text);
        yield put(receiveInitCart(result.data, action.isEditing));
    }catch(err){
        alert(err.message)
    }
}

function* requestUpdateCustomer(action){
    try{
        const response = yield call(
            Api.updateIdCustomer,
            action.data.jwt,
            action.data.customer
        );
        const result = JSON.parse(response.text);
            result.status ? yield put(updateCart(result.data.cart)) : alert('Something went wrong');
    }catch(err){
        alert(err.message)
    }
}

function* requestUpdateAddress(action){
    try{
        const response = yield call(
            Api.updateIdAddress,
            action.data.jwt,
            action.data.address,
            action.data.idCart
        );
        const result = JSON.parse(response.text);
        result.status ? yield put(updateCart(result.data.cart)) : alert('Something went wrong');
    }catch(err){
        alert(err.message)
    }
}

function* clearCustomer(action){
    try{
        const response = yield call(
            Api.clearCustomer,
            action.data.jwt,
            action.data.idCart
            );
        const result = JSON.parse(response.text);
        if (result.status) {
            yield put(updateCart(result.data.cart))
        } else {
            alert('Something went wrong');
        }

    }catch(err){
        alert(err.message)
    }
}

function* clearAddress(action){
    try{
        const response = yield call(
            Api.clearAddress,
            action.data.jwt,
            action.data.idCart,
        );
        const result = JSON.parse(response.text);
        result.status ?  action.data.onSuccess(result.data) : alert('Something went wrong');
    }catch(err){
        alert(err.message)
    }
}

function* addAddress(action){
    try{
        const response = yield call(
            Api.addAddess,
            action.data.jwt,
            action.data.address.id_country,
            action.data.address.id_state,
            action.data.address.address,
            action.data.idCart
            );
        const result = JSON.parse(response.text);
        if(result.status){
            yield put(updateCart(result.data.cart));
        }else {
            alert('Something went wrong');
        }
    }catch(err){
        alert(err.message)
    }
}

function* completeOrder(action){
    try{
        const response = yield call(
            Api.completeOrder,
            action.data.jwt,
            action.data.order,
            action.data.editingOrder
            );
        const result = JSON.parse(response.text);
        if(result.status){
            action.data.onSuccess()
        }else {
            alert('Something went wrong');
        }
    }catch(err){
        alert(err.message)
    }
}

function* cancelOrder(action){
    try{
        localStorage.setItem('orderNote', '');
        localStorage.setItem('orderReason', '');
        localStorage.setItem('orderImg', '');
        localStorage.setItem('idCart', 0);
        yield put({
            type: REQUEST_INIT_CART,
                jwt: action.data.jwt
        });
    }catch(err){
        alert(err.message)
    }
}

export function* cart(){
    yield fork(watchRequestInitCart);
    yield fork(watchUpdateShippingCost);
    yield fork(watchUpdateCarrier);
    yield fork(watchUpdateDiscount);
    yield fork(watchUpdatePaymentFee);
    yield fork(watchRequestUpdateCustomer);
    yield fork(watchRequestUpdateAddress);
    yield fork(watchClearCustomer);
    yield fork(watchClearAddress);
    yield fork(watchAddAddress);
    yield fork(watchCompleteOrder);
    yield fork(watchCancelOrder);
    yield fork(watchUpdateSaleman);
}
