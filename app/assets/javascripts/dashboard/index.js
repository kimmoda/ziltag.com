import Dashboard from './components/Dashboard'
import Home from './components/pages/Home'
import Tags from './components/pages/Tags'
import Landing from './components/pages/Landing'
import Comments from './components/pages/Comments'
import Account from './components/pages/Account'
import Verify from './components/pages/Verify'
import Verified from './components/pages/Verified'
import Install from './components/pages/Install'
import Explore from './components/pages/Explore'
import Guide from './components/pages/Guide'
import * as reducers from './reducers'
import DevTools from './containers/DevTools'
import saga from './sagas'
import initialState from './initialState'
import * as actions from './actions'

import React from 'react'
import ReactDOM from 'react-dom'
import {createStore, combineReducers, applyMiddleware, compose} from 'redux'
import {Provider} from 'react-redux'
import {Router, Route, IndexRoute, browserHistory} from 'react-router'
import { createHistory } from 'history'
import {syncHistoryWithStore, routerMiddleware} from 'react-router-redux'
import createSagaMiddleware from 'redux-saga'
import injectTapEventPlugin from 'react-tap-event-plugin'
import getMuiTheme from 'material-ui/styles/getMuiTheme'
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider'
import { Tabs } from 'react-tabs'
import '../../images/favicon.png'
import '../../images/fallback/thumb_guest.png'
import '../../images/fallback/guest.png'
import '../../images/fallback/default_guest.png'
import '../../images/social_media_logo.png'
import './tabs.scss'

injectTapEventPlugin()
Tabs.setUseDefaultStyles(false)

const sagaMiddleware = createSagaMiddleware()

const store = createStore(
  combineReducers(reducers),
  initialState,
  compose(
    applyMiddleware(sagaMiddleware),
    applyMiddleware(routerMiddleware(browserHistory)),
    __PRODUCTION__ ? f => f : DevTools.instrument()
  )
)

sagaMiddleware.run(saga)

const history = syncHistoryWithStore(browserHistory, store)

ReactDOM.render(
  <Provider store={store}>
    <MuiThemeProvider muiTheme={getMuiTheme()}>
      <Router history={history}>
        <Route path="/" component={Landing} />
        <Route path="dashboard" component={Dashboard} onEnter={
            _=>{
              store.dispatch(actions.me())
              store.dispatch(actions.retrieveRecommendedZiltagMaps())
            }
          }>
          <IndexRoute component={Home} />
          <Route path="tags" component={Tags} />
          <Route path="comments" component={Comments} />
          <Route path="account" component={Account} />
          <Route path="verify" component={Verify} />
          <Route path="verified" component={Verified} />
          <Route path="install" component={Install} />
          <Route path="explore" component={Explore} />
          <Route path="guide" component={Guide} />
        </Route>
      </Router>
    </MuiThemeProvider>
  </Provider>,
  document.getElementById('dashboard')
)