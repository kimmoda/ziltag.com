import Dashboard from './components/Dashboard'
import Home from './components/pages/Home'
import Tags from './components/pages/Tags'
import Comments from './components/pages/Comments'
import Account from './components/pages/Account'
import Verify from './components/pages/Verify'
import Verified from './components/pages/Verified'
import Install from './components/pages/Install'
import * as reducers from './reducers'
import DevTools from './containers/DevTools'
import saga from './sagas'
import initialState from './initialState'

import React from 'react'
import ReactDOM from 'react-dom'
import {createStore, combineReducers, applyMiddleware, compose} from 'redux'
import {Provider} from 'react-redux'
import {Router, Route, IndexRoute, browserHistory} from 'react-router'
import {syncHistoryWithStore, routerMiddleware} from 'react-router-redux'
import createSagaMiddleware from 'redux-saga'

let sagaMiddleware = createSagaMiddleware()

let store = createStore(
  combineReducers(reducers),
  initialState,
  compose(
    applyMiddleware(sagaMiddleware),
    applyMiddleware(routerMiddleware(browserHistory)),
    __PRODUCTION__ ? f => f : DevTools.instrument()
  )
)

sagaMiddleware.run(saga)

let history = syncHistoryWithStore(browserHistory, store)

ReactDOM.render(
  <Provider store={store}>
    <Router history={history}>
      <Route path="/dashboard" component={Dashboard}>
        <IndexRoute component={Home} />
        <Route path="tags" component={Tags} />
        <Route path="comments" component={Comments} />
        <Route path="account" component={Account} />
        <Route path="verify" component={Verify} />
        <Route path="verified" component={Verified} />
        <Route path="install" component={Install} />
      </Route>
    </Router>
  </Provider>,
  document.getElementById('dashboard')
)