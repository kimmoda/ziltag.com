import * as reducers from './reducers'
import { createStore, combineReducers } from 'redux'

export const getStore = (initState={}) => createStore(
  combineReducers(reducers),
  initState,
  typeof window === 'object' && typeof window.devToolsExtension !== 'undefined' ? window.devToolsExtension() : _ => _
)
