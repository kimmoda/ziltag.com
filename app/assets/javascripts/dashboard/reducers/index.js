import * as actionTypes from '../actions/types'
import {reducer as formReducer} from 'redux-form'
export {routerReducer as routing} from 'react-router-redux'
import merge from 'lodash/merge'

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
  },
  signIn: (state, action) => {
    switch (action.type) {
      case actionTypes.RECEIVE_SIGN_IN_ERROR:
        return {...state, _error: action.errors[0].message}
      default:
        return state
    }
  },
  signUp: (state, action) => {
    switch (action.type) {
      case actionTypes.RECEIVE_PARTNER_SIGN_UP_ERROR:
        return {...state, _error: action.errors[0].message}
      default:
        return state
    }
  }
})

export function recommendedZiltagMaps(state=[], action){
  if(action.type == actionTypes.RECEIVE_RECOMMENDED_ZILTTAG_MAPS) return action.response.result
  else return state
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

export function siteMenu(state={open: false, selected: null}, action) {
  switch (action.type) {
    case actionTypes.RECEIVE_ME:
      const me = action.response.entities.users[action.response.result]
      return me.websites ? {...state, selected: me.websites[0]} : state
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
      return {name: action.name, payload: action.payload}
    case actionTypes.CLOSE_DIALOG:
      return null
    default:
      return state
  }
}

export function me(state=null, action) {
  if(action.type == actionTypes.RECEIVE_ME) return action.response.result || state
  else return state
}

export function entities(state = {users: {}, websites: {}, ziltags: {}, ziltagMaps: {}}, action) {
  if (action.response && action.response.entities) {
    return merge({}, state, action.response.entities)
  }
  return state
}

export function video(state='begin', action) {
  switch (action.type) {
    case actionTypes.PLAY_VIDEO:
      return 'play'
    case actionTypes.PAUSE_VIDEO:
      return 'pause'
    case actionTypes.END_VIDEO:
      return 'end'
    default:
      return state
  }
}

export function videoLayer(state={open: false, state: 'play'}, action) {
  switch (action.type) {
    case actionTypes.CLOSE_VIDEO_LAYER:
      return {...state, open: false}
    case actionTypes.OPEN_VIDEO_LAYER:
      return {open: true, state: 'play'}
    case actionTypes.PLAY_VIDEO_LAYER:
      return {open: true, state: 'play'}
    case actionTypes.PAUSE_VIDEO_LAYER:
      return {open: true, state: 'pause'}
    case actionTypes.END_VIDEO_LAYER:
      return {open: true, state: 'end'}
    default:
      return state
  }
}