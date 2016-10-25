import React from 'react'
import {Router, IndexRoute, Route, browserHistory} from 'react-router'
import Home from './Home'
import Doc from './Doc'

export const getRoutes = (history=browserHistory) => (
  <Router history={browserHistory}>
    <Route path="/" component={Home}/>
    <Route path="/doc" component={Doc}/>
  </Router>
)
