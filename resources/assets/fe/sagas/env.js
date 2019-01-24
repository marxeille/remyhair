import {
    REQUEST_LOGIN,
    receiveLoginInfo,
    REQUEST_LOGOUT,
    logoutSuccess,
    REQUEST_INIT_APP,
    receiveInitApp, REQUEST_REFRESH_TOKEN, loginSuccess
} from '../actions/env'
import { put, call, fork, takeLatest } from "redux-saga/effects"
import Api from '../api'

function* watchRequestLogin() {
    yield takeLatest(REQUEST_LOGIN, requestLogin);
}

function* watchRequestLogout() {
    yield takeLatest(REQUEST_LOGOUT, requestLogout);
}

function* watchRequestInitApp() {
    yield takeLatest(REQUEST_INIT_APP, requestInitApp);
}

function* watchRequestRefreshToken() {
    yield takeLatest(REQUEST_REFRESH_TOKEN, requestRefreshToken);
}

function* requestLogin(action){
    try{
        const response = yield call(
            Api.login,
            action.email,
            action.password,
        );
        const result = JSON.parse(response.text);
        if(result.status){
            location.href = '/';
            localStorage.setItem("auth", JSON.stringify(result));
        }
            yield put(receiveLoginInfo(result));
    }catch(err){
        alert(err.message)
    }
}

function* requestLogout(action){
    try{
        if(localStorage.getItem("auth")){
            localStorage.removeItem('auth');
        }
            yield put(logoutSuccess());
    }catch(err){
        alert(err.message);
    }
}

function* requestInitApp(action){
    try{
        const response = yield call(
            Api.initApp,
            action.jwt
        );
        const result = JSON.parse(response.text);
        localStorage.setItem('idCart', result.data.cart.id);
        yield put(receiveInitApp(result));
    }catch(err){
        alert(err.message);
    }
}

function* requestRefreshToken(action){
    try{
        const response = yield call(
            Api.refreshToken,
            action.jwt,
            action.data.access_token,
        );
        const result = JSON.parse(response.text);
        if(result.status){
            const authInfo = JSON.parse(localStorage.getItem('auth'));
            const newAuthInfo = Object.assign({}, authInfo, {
                access_token: result.data.access_token,
                expiration: result.data.expiration
            });
            localStorage.setItem('auth', JSON.stringify(newAuthInfo));
            yield put(loginSuccess(newAuthInfo));
        }else{
            localStorage.removeItem('auth');
            window.location.reload()
        }
    }catch(err){
        localStorage.removeItem('auth');
        window.location.reload()
    }
}

export function* env(){
    yield fork(watchRequestLogin);
    yield fork(watchRequestLogout);
    yield fork(watchRequestInitApp);
    yield fork(watchRequestRefreshToken);
}
