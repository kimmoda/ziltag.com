import React from 'react'
import {Router, IndexRoute, Route, browserHistory} from 'react-router'
import {I18nextProvider} from 'react-i18next'
import Home from './Home'

export const getRoutes = (history=browserHistory) => (
  <Router history={browserHistory}>
    <Route path="/" component={Home}/>
  </Router>
)
