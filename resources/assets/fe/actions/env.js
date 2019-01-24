export const REQUEST_LOGIN = 'env/REQUEST_LOGIN'
export const RECEIVE_LOGIN_INFO = 'env/RECEIVE_LOGIN_INFO'
export const LOGIN_SUCCESS = 'env/LOGIN_SUCCESS'
export const REQUEST_LOGOUT = 'env/REQUEST_LOGOUT'
export const LOGOUT_SUCCESS = 'env/LOGOUT_SUCCESS'
export const REQUEST_INIT_APP = 'env/INIT_APP'
export const RECEIVE_INIT_APP = 'env/RECEIVE_INIT_APP'
export const REQUEST_REFRESH_TOKEN = 'env/REQUEST_REFRESH_TOKEN'
export const RECEIVE_NEW_TOKEN = 'env/RECEIVE_NEW_TOKEN'


export function requestLogin(email, password, remember){
    return {
        type: REQUEST_LOGIN,
        email: email,
        password: password,
        remember: remember
    }
}

export function receiveLoginInfo(result){
    return {
        type: RECEIVE_LOGIN_INFO,
        login: result.status,
        employee: result.data.employee ? result.data.employee : {},
        jwt: result.data.access_token ? result.data.access_token : null,
        message: result.message,
    }
}

export function loginSuccess(authInfo){
    return {
        type: LOGIN_SUCCESS,
        login: authInfo.status,
        employee: authInfo.data.employee,
        jwt: authInfo.data.access_token,
        message: authInfo.message,
    }
}

export function requestLogout(){
    return {
        type: REQUEST_LOGOUT,
    }
}

export function logoutSuccess(){
    return {
        type: LOGOUT_SUCCESS,
    }
}

export function requestInitApp(jwt){
    return {
        type: REQUEST_INIT_APP,
        jwt: jwt
    }
}

export function receiveInitApp(action){
    action.data.isInited =  true;
    return {
        type: RECEIVE_INIT_APP,
        data: action.data
    }
}

export function requestRefreshToken(action){
    return {
        type: REQUEST_REFRESH_TOKEN,
        data: action.data
    }
}

export function receiveNewToken(action){
    return {
        type: RECEIVE_NEW_TOKEN,
        data: action.data
    }
}


