import * as actionTypes from '../actions/types'
import * as actions from '../actions'
import * as API from '../apis'
import { takeEvery } from 'redux-saga'
import { call, put, fork } from 'redux-saga/effects'
import { push } from 'react-router-redux'

function* verify(action) {
  const { password, password_confirmation, confirmation_token } = action
  const data = yield call(API.verify, password, password_confirmation, confirmation_token)
  if(data.errors) yield put(actions.requestVerifyFailed(data.errors))
  else {
    yield put(push('/dashboard/verified'))
    yield put({type: actionTypes.REQUEST_VERIFY_SUCCEEDED})
  }
}

function* watchVerify() {
  yield* takeEvery(actionTypes.REQUEST_VERIFY, verify)
}

export default function* root() {
  yield [
    fork(watchVerify)
  ]
}