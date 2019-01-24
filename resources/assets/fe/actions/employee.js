export const REQUEST_LEADERS = 'employee/REQUEST_LEADERS'
export const RECEIVE_LEADERS = 'employee/RECEIVE_LEADERS'
export const ADD_EMPLOYEE = 'employee/ADD_EMPLOYEE'
export const RECEIVE_NEW_EMPLOYEE = 'employee/RECEIVE_NEW_EMPLOYEE'
export const REQUEST_LIST = 'employee/REQUEST_LIST'
export const REQUEST_LIST_CUSTOMER = 'employee/REQUEST_LIST_CUSTOMER'
export const REQUEST_LIST_SUPPORT = 'employee/REQUEST_LIST_SUPPORT'
export const RECEIVE_LIST = 'employee/RECEIVE_LIST'
export const RECEIVE_LIST_CUSTOMER = 'employee/RECEIVE_LIST_CUSTOMER'
export const RECEIVE_LIST_SUPPORT = 'employee/RECEIVE_LIST_SUPPORT'
export const REQUEST_FILTER = 'employee/REQUEST_FILTER'
export const REQUEST_FILTER_CUSTOMER = 'employee/REQUEST_FILTER_CUSTOMER'
export const REQUEST_FILTER_SUPPORT = 'employee/REQUEST_FILTER_SUPPORT'
export const REQUEST_EMPLOYEE = 'employee/REQUEST_EMPLOYEE'
export const RECEIVE_EMPLOYEE = 'employee/RECEIVE_EMPLOYEE'

export function requestLeaders(jwt){
    return {
        type: REQUEST_LEADERS,
        jwt: jwt
    }
}

export function receiveLeaders(data){
    return {
        type: RECEIVE_LEADERS,
        data: data
    }
}

export function receiveNewEmployee(data){
    return {
        type: RECEIVE_NEW_EMPLOYEE,
        data: data
    }
}

export function requestGetList(data){
    return {
        type: REQUEST_LIST,
        jwt: data
    }
}

export function requestGetListCustomer(jwt, id){
    return {
        type: REQUEST_LIST_CUSTOMER,
        data: {
            id: id
        },
        jwt: jwt
    }
}

export function requestGetListSupport(jwt, id){
    return {
        type: REQUEST_LIST_SUPPORT,
        data: {
            id: id
        },
        jwt: jwt
    }
}

export function receiveList(data){
    return {
        type: RECEIVE_LIST,
        data: data
    }
}

export function receiveListCustomer(data){
    return {
        type: RECEIVE_LIST_CUSTOMER,
        data: data
    }
}

export function receiveListSupport(data){
    return {
        type: RECEIVE_LIST_SUPPORT,
        data: data
    }
}

export function requestFilter( data){
    return {
        type: REQUEST_FILTER,
        data: data,
    }
}

export function requestFilterListCustomer(data){
    return {
        type: REQUEST_FILTER_CUSTOMER,
        data: data,
    }
}

export function requestFilterListSupport(data){
    return {
        type: REQUEST_FILTER_SUPPORT,
        data: data,
    }
}

export function requestEmployee(jwt, id){
    return {
        type: REQUEST_EMPLOYEE,
        data: {
            id: id
        },
        jwt: jwt
    }
}

export function receiveEmployee(data){
    return {
        type: RECEIVE_EMPLOYEE,
        data: data
    }
}

export function addEmployee(jwt, form){
    form.dateOfBirth = form.dateOfBirth.toDate();
    form.joinDate = form.joinDate.toDate();
    form.dateOfContract = form.dateOfContract.toDate();
    form.dateOfGraduation = form.dateOfGraduation.toDate();
    return {
        type: ADD_EMPLOYEE,
        data: {
            jwt: jwt,
            form: form
        }
    }
}

