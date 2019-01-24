import { take, put, call, fork, select, cancelled, takeLatest } from "redux-saga/effects"
import Api from '../api'
import {ADD_GROUP, GET_ALL_GROUPS, receiveAddGroup, receiveGroups} from "../actions/group";

function* watchAddGroup() {
    yield takeLatest(ADD_GROUP, addGroup);
}

function* watchGetGroups() {
    yield takeLatest(GET_ALL_GROUPS, getGroups);
}

function* addGroup(action) {
    try{
        const response = yield call(
            Api.addGroup,
            action.data
        );
        const result = JSON.parse(response.text);
        yield put(receiveAddGroup(result));
    }catch(err){
        alert(err.message)
    }
}

function* getGroups(action) {
    try{
        const response = yield call(
            Api.getGroups,
            action.data
        );
        const result = JSON.parse(response.text);
        if(result.status){
            yield put(receiveGroups(result.data))
        }else{
            alert(result.msg)
        }
    }catch(err){
        alert(err.message)
    }

}


export function* group(){
    yield fork(watchAddGroup);
    yield fork(watchGetGroups);
}
