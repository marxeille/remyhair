import { take, put, call, fork, select, cancelled, takeLatest } from "redux-saga/effects"
import Api from '../../api'
import {
    REQUEST_ADD_PRODUCT,
    REQUEST_REMOVE_PRODUCT,
    REQUEST_UPDATE_PRODUCT,
    REQUEST_IMPORT_PRODUCTS
} from "../../actions/order/product";
import { isCallbackFunction } from '../../utility'
import {receiveInitCart} from "../../actions/order/cart";

function* watchRequestAddProduct() {
    yield takeLatest(REQUEST_ADD_PRODUCT, requestAddProduct);
}

function* watchRequestUpdateProduct() {
    yield takeLatest(REQUEST_UPDATE_PRODUCT, requestUpdateProduct);
}

function* watchRequestRemoveProduct() {
    yield takeLatest(REQUEST_REMOVE_PRODUCT, requestRemoveProduct);
}

function* watchRequestImportProducts() {
    yield takeLatest(REQUEST_IMPORT_PRODUCTS, requestImportProducts);
}

function* requestAddProduct(action){
    try{
        const response = yield call(
            Api.requestAddProduct,
            action.data.jwt,
            action.data.data,
        );
        const result = JSON.parse(response.text);
        if(result.status){
            isCallbackFunction(action.data.onSuccess) ? action.data.onSuccess(result.data) : null
        }else{
            isCallbackFunction(action.data.onError) ? action.data.onError(result.data) : null
        }
        yield put(receiveInitCart(result.data, action.isEditing));
    }catch(err){
        alert(err.message)
    }
}

function* requestUpdateProduct(action){
    try{
        const response = yield call(
            Api.updateProduct,
            action.data.jwt,
            action.data.data,
        );
        const result = JSON.parse(response.text);
        if(result.status){
            isCallbackFunction(action.data.onSuccess) ? action.data.onSuccess(result.data) : null
        }else{
            isCallbackFunction(action.data.onError) ? action.data.onError(result.data) : null
        }
        yield put(receiveInitCart(result.data, action.isEditing));
    }catch(err){
        alert(err.message)
    }
}

function* requestRemoveProduct(action){
    try{
        const response = yield call(
            Api.removeProduct,
            action.data.jwt,
            action.data.data,
        );
        const result = JSON.parse(response.text);
        if(result.status){
            isCallbackFunction(action.data.onSuccess) ? action.data.onSuccess(result.data) : null
        }else{
            isCallbackFunction(action.data.onError) ? action.data.onError(result.data) : null
        }
        yield put(receiveInitCart(result.data, action.isEditing));
    }catch(err){
        alert(err.message)
    }
}

function* requestImportProducts(action){
    try{
        const response = yield call(
            Api.importProducts,
            action.data.jwt,
            action.data.data,
        );
        const result = JSON.parse(response.text);
        if(result.status){
            isCallbackFunction(action.data.onSuccess) ? action.data.onSuccess(result.data) : null
        }else{
            isCallbackFunction(action.data.onError) ? action.data.onError(result.data) : null
        }
        yield put(receiveInitCart(result.data, action.isEditing));
    }catch(err){
        alert(err.message)
    }
}

export function* product(){
    yield fork(watchRequestAddProduct);
    yield fork(watchRequestUpdateProduct);
    yield fork(watchRequestRemoveProduct);
    yield fork(watchRequestImportProducts);
}
