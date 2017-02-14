import {takeEvery, call, put} from 'redux-saga/effects'
import {forgotPassword} from '../api'
import {failForgotPassword, openModal} from '../actions'

export default function* () {
  yield* takeEvery('REQUEST_FORGOT_PASSWORD', requestForgotPassword)
}

function* requestForgotPassword(action){
  const response = yield call(forgotPassword, action.email)
  if(response.errors) yield put(failForgotPassword(response.errors[0].message))
  else yield put(openModal('checked', {message: 'Email Sent!'}))
}
