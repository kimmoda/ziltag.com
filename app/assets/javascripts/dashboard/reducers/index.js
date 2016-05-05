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
  },
  password: (state, action) => {
    switch (action.type) {
      case actionTypes.RECEIVE_CHANGE_PASSWORD_FAILURE:
        return {...state, _error: action.errors[0].message}
      default:
        return state
    }
  }
})

export function me(state=null, action){
  switch (action.type) {
    case actionTypes.RECEIVE_ME:
      return action.me
    default:
      return state
  }
}

export function recommendedZiltagMaps(state=[], action){
  switch (action.type) {
    case actionTypes.RECEIVE_RECOMMENDED_ZILTTAG_MAPS:
      return action.ziltag_maps
    default:
      return state
  }
}

export function modal(state={isActive: false}, action) {
  switch (action.type) {
    case actionTypes.OPEN_MODAL:
      return {isActive: true, src: action.src}
    case actionTypes.CLOSE_MODAL:
      return {isActive: false}
    default:
      return state
  }
}

export function siteMenu(state={open: false, target: null, selected: 0}, action) {
  switch (action.type) {
    case actionTypes.SELECT_SITE_MENU_ITEM:
      return {...state, selected: action.selected}
    case actionTypes.OPEN_SITE_MENU:
      return {...state, open: true, target: action.target}
    case actionTypes.CLOSE_SITE_MENU:
      return {...state, open: false}
    default:
      return state
  }
}

export function dialog(state=null, action){
  switch (action.type) {
    case actionTypes.OPEN_DIALOG:
      return action.name
    case actionTypes.CLOSE_DIALOG:
      return null
    default:
      return state
  }
}