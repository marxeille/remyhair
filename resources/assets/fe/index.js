import React from 'react'
import { render } from 'react-dom'
import { createStore, applyMiddleware, combineReducers } from 'redux'
import * as rootReducer from './reducers'
import { Provider } from 'react-redux'
import  createSagaMiddleware  from 'redux-saga'
import * as sagas from './sagas'
import { BrowserRouter as Router, Route } from 'react-router-dom'
import AppContainer from './containers/app'
import { createLogger }  from 'redux-logger'
import createHistory from "history/createBrowserHistory";
import {
    ConnectedRouter,
    routerReducer,
    routerMiddleware,
    push
} from "react-router-redux";
const history = createHistory();
const middleware = routerMiddleware(history);
const sagaMiddleware = createSagaMiddleware();
const store = createStore(
    combineReducers({...rootReducer, router: routerReducer}),
    applyMiddleware(sagaMiddleware,  createLogger(), middleware));
sagaMiddleware.run(sagas.root).done.catch((error) => console.warn(error));

render(
    <Provider store={store}>
        <ConnectedRouter  history={history}>
            <Route path="/" component={AppContainer} />
        </ConnectedRouter>
    </Provider>,
    document.getElementById('root')
)
