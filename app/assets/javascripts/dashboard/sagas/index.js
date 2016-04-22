import * as actionTypes from '../actions/types'
import * as actions from '../actions'
import * as API from '../apis'
import { takeEvery } from 'redux-saga'
import { call, put, fork } from 'redux-saga/effects'
import { push } from 'react-router-redux'

function* fetchProfile() {
  const result = yield call(API.graphql, '{me{avatar,confirmed,email,name,website{token,url,platform}}}')
  if(result.data) yield put({type: actionTypes.RECEIVE_ME, me: result.data.me})
  else if (result.errors) console.error(result.errors)
}

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
    fork(fetchProfile),
    fork(watchVerify)
  ]
}