import { take, put, call, fork, select, cancelled } from "redux-saga/effects";
import { env } from './env'
import { customer } from "./customer";
import { workProfile } from "./workprofile";
import { support } from "./support";
import { group } from "./group";
import {employee} from "./employee";
import { history } from "./history";
import { hair } from "./hair";
import { customerReport} from "./report/customer";
import { orderReport} from "./report/order";
import {cart} from "./sale/cart";
import {product} from "./sale/product";
import {order} from "./order";
import {dashboard} from "./dashboard";
import {saleCommission} from "./saleCommission";
import {payment} from "./payment";
import {invoice} from "./invoice";
import {jobTitle} from "./jobTitle";
import { receiveInitApp } from '../actions/env'
import Api from '../api'

function* initApp() {
    const auth = JSON.parse(localStorage.getItem('auth'));
    if (auth !== null) {
        try{
            const response = yield call( Api.initApp, auth.data.access_token);
            const result = JSON.parse(response.text);
            localStorage.setItem('idCart', result.data.cart.id);
            yield put(receiveInitApp(result));
        }catch(err){
            alert(err.message);
        }
    }
}

export function* root() {
    yield fork(initApp);
    yield fork(env);
    yield fork(history);
    yield fork(customer);
    yield fork(workProfile);
    yield fork(support);
    yield fork(hair);
    yield fork(group);
    yield fork(employee);
    yield fork(customerReport);
    yield fork(orderReport);
    yield fork(cart);
    yield fork(product);
    yield fork(order);
    yield fork(dashboard);
    yield fork(saleCommission);
    yield fork(payment);
    yield fork(invoice);
    yield fork(jobTitle);
}
