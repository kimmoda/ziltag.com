import Dashboard from './components/Dashboard'
import Home from './components/pages/Home'
import Tags from './components/pages/Tags'
import Comments from './components/pages/Comments'
import Account from './components/pages/Account'
import * as reducers from './reducers'
import DevTools from './containers/DevTools'

import React from 'react'
import ReactDOM from 'react-dom'
import {createStore, combineReducers} from 'redux'
import {Provider} from 'react-redux'
import {Router, Route, IndexRoute, browserHistory} from 'react-router'
import {syncHistoryWithStore} from 'react-router-redux'


let store = createStore(combineReducers(reducers), __PRODUCTION__ ? f => f : DevTools.instrument())
let history = syncHistoryWithStore(browserHistory, store)

ReactDOM.render(
  <Provider store={store}>
    <Router history={history}>
      <Route path="/dashboard" component={Dashboard}>
        <IndexRoute component={Home} />
        <Route path="tags" component={Tags} />
        <Route path="comments" component={Comments} />
        <Route path="account" component={Account} />
      </Route>
    </Router>
  </Provider>,
  document.getElementById('dashboard')
)