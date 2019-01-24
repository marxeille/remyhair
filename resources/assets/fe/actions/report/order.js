export const REQUEST_ORDER_LIST = 'report/order/REQUEST_ORDER_LIST';
export const REQUEST_PRODUCT_LIST = 'report/order/REQUEST_PRODUCT_LIST';
export const REQUEST_CLOSURE_LIST = 'report/order/REQUEST_CLOSURE_LIST';
export const RECEIVE_ORDER_LIST = 'report/order/RECEIVE_ORDER_LIST';
export const RECEIVE_PRODUCT_REPORT = 'report/order/RECEIVE_PRODUCT_REPORT';
export const RECEIVE_CLOSURE_REPORT = 'report/order/RECEIVE_CLOSURE_REPORT';
export const REQUEST_ORDER_FILTER = 'report/order/REQUEST_ORDER_FILTER';
export const REQUEST_PRODUCT_FILTER = 'report/order/REQUEST_PRODUCT_FILTER';
export const REQUEST_CLOSURE_FILTER = 'report/order/REQUEST_CLOSURE_FILTER';
export const REQUEST_ORDER_STATS = 'report/order/REQUEST_ORDER_STATS';
export const RECEIVE_ORDER_STATS = 'report/order/RECEIVE_ORDER_STATS';
export const RECEIVE_ORDER_SUMMARY = 'report/order/RECEIVE_ORDER_SUMMARY';
export const REQUEST_ORDER_SUMMARY = 'report/order/REQUEST_ORDER_SUMMARY';
export const REQUEST_ORDER_WEFT = 'report/order/REQUEST_ORDER_WEFT';
export const RECEIVE_ORDER_WEFT = 'report/order/RECEIVE_ORDER_WEFT';
export const RECEIVE_ORDER_CLOSURE = 'report/order/RECEIVE_ORDER_CLOSURE';
export const REQUEST_ORDER_CLOSURE = 'report/order/REQUEST_ORDER_CLOSURE';
export const REQUEST_REPORT_TYPE = 'report/order/REQUEST_REPORT_TYPE';
export const REQUEST_REPORT_SIZE = 'report/order/REQUEST_REPORT_SIZE';
export const RECEIVE_REPORT_TYPE = 'report/order/RECEIVE_REPORT_TYPE';
export const REQUEST_REPORT_COUNTRY = 'report/order/REQUEST_REPORT_COUNTRY';
export const RECEIVE_REPORT_COUNTRY = 'report/order/RECEIVE_REPORT_COUNTRY';
export const RECEIVE_REPORT_SIZE = 'report/order/RECEIVE_REPORT_SIZE';
export const REQUEST_REPORT_CUSTOMER = 'report/order/REQUEST_REPORT_CUSTOMER';
export const RECEIVE_REPORT_CUSTOMER = 'report/order/RECEIVE_REPORT_CUSTOMER';
export const REQUEST_REPORT_CUSTOMER_BALANCE = 'report/order/REQUEST_REPORT_CUSTOMER_BALANCE';
export const RECEIVE_REPORT_CUSTOMER_BALANCE = 'report/order/RECEIVE_REPORT_CUSTOMER_BALANCE';
export const REQUEST_REPORT_PAYMENT = 'report/order/REQUEST_REPORT_PAYMENT';
export const RECEIVE_REPORT_PAYMENT = 'report/order/RECEIVE_REPORT_PAYMENT';

export function requestGetOrderList(jwt){
    return {
        type: REQUEST_ORDER_LIST,
        jwt: jwt
    }
}

export function requestGetTotalProductList(jwt){
    return {
        type: REQUEST_PRODUCT_LIST,
        jwt: jwt
    }
}

export function requestGetClosureList(jwt){
    return {
        type: REQUEST_CLOSURE_LIST,
        jwt: jwt
    }
}

export function receiveOrderStats(data){
    return {
        type: RECEIVE_ORDER_STATS,
        data: data.data
    }
}


export function receiveListProductReport(data){
    return {
        type: RECEIVE_PRODUCT_REPORT,
        data: data.data
    }
}

export function receiveListClosureReport(data){
    return {
        type: RECEIVE_CLOSURE_REPORT,
        data: data.data
    }
}

export function requestOrderFilter(data){
    return {
        type: REQUEST_ORDER_FILTER,
        data: data
    }
}

export function requestProductFilter(data){
    return {
        type: REQUEST_PRODUCT_FILTER,
        data: data
    }
}

export function requestClosureFilter(data){
    return {
        type: REQUEST_CLOSURE_FILTER,
        data: data
    }
}

export function requestGetOrderStats(data){
    return {
        type: REQUEST_ORDER_STATS,
        data: data
    }
}

export function requestGetOrderSummary(data){
    return {
        type: REQUEST_ORDER_SUMMARY,
        data: data
    }
}

export function requestGetReportType(data){
    return {
        type: REQUEST_REPORT_TYPE,
        data: data
    }
}

export function requestGetReportSize(data){
    return {
        type: REQUEST_REPORT_SIZE,
        data: data
    }
}

export function requestGetOrderWeft(data){
    return {
        type: REQUEST_ORDER_WEFT,
        data: data
    }
}

export function receiveGetOrderWeft(data){
    return {
        type: RECEIVE_ORDER_WEFT,
        data: data
    }
}

export function receiveOrderSummary(data){
    return {
        type: RECEIVE_ORDER_SUMMARY,
        data: data
    }
}

export function requestOrderClosure(data){
    return {
        type: REQUEST_ORDER_CLOSURE,
        data: data
    }
}

export function receiveOrderClosure(data){
    return {
        type: RECEIVE_ORDER_CLOSURE,
        data: data
    }
}

export function receiveReportType(data){
    return {
        type: RECEIVE_REPORT_TYPE,
        data: data
    }
}

export function receiveReportSize(data){
    return {
        type: RECEIVE_REPORT_SIZE,
        data: data
    }
}

export function requestReportCountry(data){
    return {
        type: REQUEST_REPORT_COUNTRY,
        data: data
    }
}

export function receiveReportCountry(data){
    return {
        type: RECEIVE_REPORT_COUNTRY,
        data: data
    }
}

export function requestReportCustomer(data){
    return {
        type: REQUEST_REPORT_CUSTOMER,
        data: data
    }
}

export function receiveReportCustomer(data){
    return {
        type: RECEIVE_REPORT_CUSTOMER,
        data: data
    }
}

export function requestReportCustomerBalance(data){
    return {
        type: REQUEST_REPORT_CUSTOMER_BALANCE,
        data: data
    }
}

export function receiveReportCustomerBalance(data){
    return {
        type: RECEIVE_REPORT_CUSTOMER_BALANCE,
        data: data
    }
}

export function requestReportPayment(data){
    return {
        type: REQUEST_REPORT_PAYMENT,
        data: data
    }
}

export function receiveReportPayment(data){
    return {
        type: RECEIVE_REPORT_PAYMENT,
        data: data
    }
}




