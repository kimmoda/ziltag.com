import * as actionTypes from '../actions/types'
import * as actions from '../actions'
import * as API from '../apis'
import { takeEvery } from 'redux-saga'
import { take, call, put, fork, cancel } from 'redux-saga/effects'
import { push } from 'react-router-redux'

function delay(ms){
  return new Promise(resolve => setTimeout(resolve, ms))
}

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
    yield put(push('/verified'))
    yield put({type: actionTypes.REQUEST_VERIFY_SUCCEEDED})
  }
}

function* watchVerify() {
  yield* takeEvery(actionTypes.REQUEST_VERIFY, verify)
}

function* sign_out(action){
  try {
    yield call(API.sign_out)
    window.location.replace('/users/sign_in')
  } catch (e) {
  }
}

function* watchSignOut() {
  yield* takeEvery(actionTypes.REQUEST_SIGN_OUT, sign_out)
}

function* redirectToRoot() {
  yield call(delay, 5000)
  yield put(push('/'))
}

function* watchRouterLocationChange() {
  let lastTask
  while(true) {
    const action = yield take('@@router/LOCATION_CHANGE')
    if(action.payload.pathname == '/verified'){
      if(lastTask) yield cancel(lastTask)
      lastTask = yield fork(redirectToRoot)
    }
  }
}

export default function* root() {
  yield [
    fork(fetchProfile),
    fork(watchVerify),
    fork(watchSignOut),
    fork(watchRouterLocationChange)
  ]
}