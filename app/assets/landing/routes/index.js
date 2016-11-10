import React from 'react'
import {Router, IndexRoute, Route, browserHistory} from 'react-router'
import Home from './Home'
import Doc from './Doc'
import Demo from './Demo'
import SignedUp from './SignedUp'

export const getRoutes = (history=browserHistory) => (
  <Router history={browserHistory} onUpdate={() => window.scrollTo(0, 0)}>
    <Route path="/" component={Home}/>
    <Route path="/doc" component={Doc}/>
    <Route path="/preview/:id" component={Demo}/>
    <Route path="/m/signed_up" component={SignedUp}/>
  </Router>
)
