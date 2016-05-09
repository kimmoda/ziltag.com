import * as actionTypes from './types'

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

export function openDialog(name) {
  return {type: actionTypes.OPEN_DIALOG, name}
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
