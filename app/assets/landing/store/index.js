import {createStore, combineReducers, compose, applyMiddleware} from 'redux'
import defaultState from './default'
import * as reducers from '../reducers'
import {sagaMiddleware} from '../saga'

export const getStore = (initState={}) => createStore(
  combineReducers(reducers),
  Object.assign({}, defaultState, initState),
  compose(
    typeof window === 'object' ? applyMiddleware(sagaMiddleware) : _ => _,
    typeof window === 'object' && typeof window.devToolsExtension !== 'undefined' ? window.devToolsExtension() : _ => _
  )
)
