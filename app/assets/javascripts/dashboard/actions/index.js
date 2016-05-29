import * as actionTypes from './types'
import { normalize } from 'normalizr'
import { website as websiteType } from '../schema'

function composeURL(params){
  const {platform, url, tumblr, blogger} = params
  var newURL
  switch (platform) {
    case 'tumblr':
      return `http://${tumblr}.tumblr.com`
    case 'blogger':
      return `http://${blogger}.blogspot.com`
      break;
    default:
      return url
  }
}

export function me() {
  return {
    type: actionTypes.REQUEST_ME
  }
}

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
    response: normalize({id, delete: true}, websiteType)
  }
}

export function requestUpdateWebsite(id, params){
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
    type: actionTypes.REQUEST_UPDATE_WEBSITE,
    id,
    url: newURL
  }
}

export function receiveUpdateWebsite(website) {
  return {
    type: actionTypes.RECEIVE_UPDATE_WEBSITE,
    response: normalize(website, websiteType)
  }
}

export function requestSignIn(params) {
  return {
    type: actionTypes.REQUEST_SIGN_IN,
    ...params
  }
}

export function receiveSignInError(errors) {
  return {
    type: actionTypes.RECEIVE_SIGN_IN_ERROR,
    errors
  }
}

export function receiveSignIn(user) {
  return {
    type: actionTypes.RECEIVE_SIGN_IN,
    user
  }
}

export function requestPartnerSignUp(params){
  const {username, email} = params
  const url = composeURL(params)
  return {
    type: actionTypes.REQUEST_PARTNER_SIGN_UP,
    username,
    email,
    url
  }
}

export function receivePartnerSignUp(){
  return {
    type: actionTypes.RECEIVE_PARTNER_SIGN_UP
  }
}

export function receivePartnerSignUpError(errors){
  return {
    type: actionTypes.RECEIVE_PARTNER_SIGN_UP_ERROR,
    errors
  }
}

export function playVideo() {
  return {
    type: actionTypes.PLAY_VIDEO
  }
}

export function pauseVideo() {
  return {
    type: actionTypes.PAUSE_VIDEO
  }
}

export function endVideo() {
  return {
    type: actionTypes.END_VIDEO
  }
}