import { take, put, call, fork, select, cancelled, takeLatest } from "redux-saga/effects"
import Api from '../api'
import { GET_DATA, receiveDashboard } from "../actions/dashboard";

function* watchGetData() {
    yield takeLatest(GET_DATA, getData);
}


function* getData(action) {
    try{
        const response = yield call(Api.getDataDashBoard, action.jwt, action.range, action.summaryStartDate, action.startDate, action.endDate);
        const result = JSON.parse(response.text);
        yield put(receiveDashboard(result.data, action.range));
    }catch(err){
        alert(err.message)
    }
}


export function* dashboard(){
    yield fork(watchGetData);
}
