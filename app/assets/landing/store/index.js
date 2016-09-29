import {createStore, combineReducers, compose, applyMiddleware} from 'redux'
import {routerMiddleware} from 'react-router-redux'
import {browserHistory} from 'react-router'
import defaultState from './default'
import * as reducers from '../reducers'
import {sagaMiddleware} from '../saga'

export const getStore = (initState={}) => createStore(
  combineReducers(reducers),
  Object.assign({}, defaultState, initState),
  compose(
    typeof window === 'object' ? applyMiddleware(sagaMiddleware) : _ => _,
    typeof window === 'object' ? applyMiddleware(routerMiddleware(browserHistory)) : _ => _,
    typeof window === 'object' && typeof window.devToolsExtension !== 'undefined' ? window.devToolsExtension() : _ => _
  )
)
