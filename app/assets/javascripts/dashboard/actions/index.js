import * as actionTypes from './types'
import { normalize } from 'normalizr'
import { website } from '../schema'

export function requestVerify(params) {
  const {password, password_confirmation, confirmation_token} = params
  return {
    type: actionTypes.REQUEST_VERIFY,
    password,
    password_confirmation,
    confirmation_token
  }
}

export function requestVerifyFailed(errors) {
  return {
    type: actionTypes.REQUEST_VERIFY_FAILED,
    errors
  }
}

export function openIframeModal(src) {
  return {
    type: actionTypes.OPEN_MODAL,
    src
  }
}

export function signOut() {
  return { type: actionTypes.REQUEST_SIGN_OUT }
}

export function openDialog(name, payload) {
  return {type: actionTypes.OPEN_DIALOG, name, payload}
}

export function closeDialog() {
  return {type: actionTypes.CLOSE_DIALOG}
}

export function requestChangePassword(params) {
  const {oldPassword, newPassword, confirmPassword} = params
  return {
    type: actionTypes.REQUEST_CHANGE_PASSWORD,
    oldPassword,
    newPassword,
    confirmPassword
  }
}

export function receivePasswordFailure(errors) {
  return {
    type: actionTypes.RECEIVE_CHANGE_PASSWORD_FAILURE,
    errors
  }
}

export function requestAddWebsite(params) {
  const {platform, url, tumblr, blogger} = params
  var newURL
  switch (platform) {
    case 'tumblr':
      newURL = `http://${tumblr}.tumblr.com`
      break;
    case 'blogger':
      newURL = `http://${blogger}.blogspot.com`
      break;
    default:
      newURL = url
  }
  return {
    type: actionTypes.REQUEST_ADD_WEBSITE,
    url: newURL
  }
}

export function requestDeleteWebsite(id) {
  return {
    type: actionTypes.REQUEST_DELETE_WEBSITE,
    id
  }
}

export function receiveDeleteWebsite(id) {
  return {
    type: actionTypes.RECEIVE_DELETE_WEBSITE,
    response: normalize({id, delete: true}, website)
  }
}