export {routerReducer as routing} from 'react-router-redux'
export * from './modal'
export * from './demo'
export * from './lang'
export * from './window'

import * as forms from './forms'
import {reducer as formReducer} from 'redux-form'
export const form = formReducer.plugin(forms)

export function isSignedIn(state=false, action){
  return state
}

export function isMobile(state=false, action) {
  return state
}
