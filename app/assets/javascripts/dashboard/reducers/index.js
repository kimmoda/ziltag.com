import * as actionTypes from '../actions/types'
import {reducer as formReducer} from 'redux-form'
export {routerReducer as routing} from 'react-router-redux'

export const form = formReducer.plugin({
  verify: (state, action) => {
    switch (action.type) {
      case actionTypes.REQUEST_VERIFY_FAILED:
        return {...state, _error: action.errors[0].message}
      default:
        return state
    }
  }
})