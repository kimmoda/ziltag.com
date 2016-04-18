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

// export function requestVerifySucceed(errors) {
// }

export function requestVerifyFailed(errors) {
  return {
    type: actionTypes.REQUEST_VERIFY_FAILED,
    errors
  }
}