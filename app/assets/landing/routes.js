import React from 'react'
import {Router, IndexRoute, Route, browserHistory} from 'react-router'
import Home from 'pages/Home'

export const getRoutes = (history=browserHistory) => (
  <Router history={browserHistory}>
    <Route path="/" component={Home}/>
  </Router>
)
