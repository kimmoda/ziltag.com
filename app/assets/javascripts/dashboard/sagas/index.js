import * as actionTypes from '../actions/types'
import * as actions from '../actions'
import * as API from '../apis'
import {user, ziltagMap} from '../schema'
import { takeEvery } from 'redux-saga'
import { take, call, put, fork, cancel } from 'redux-saga/effects'
import { push } from 'react-router-redux'
import { normalize, arrayOf } from 'normalizr'

function delay(ms){
  return new Promise(resolve => setTimeout(resolve, ms))
}

function* fetchMe() {
  const response = yield call(API.fetchMe)
  yield put({type: actionTypes.RECEIVE_ME, response: normalize(response.data.me, user)})
}

function* fetchRecommendedZiltagMaps() {
  const response = yield call(API.fetchRecommendedZiltagMaps)
  yield put({type: actionTypes.RECEIVE_RECOMMENDED_ZILTTAG_MAPS, response: normalize(response.data.recommended_ziltag_maps, arrayOf(ziltagMap))})
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

function* requestChangePassword(action) {
  const {oldPassword, newPassword, confirmPassword} = action
  const data = yield call(API.changePassword, oldPassword, newPassword, confirmPassword)
  if(data.errors) yield put(actions.receivePasswordFailure(data.errors))
  else {
    yield put(actions.openDialog('password_changed'))
  }
}

function* watchRequestChangePassword() {
  yield* takeEvery(actionTypes.REQUEST_CHANGE_PASSWORD, requestChangePassword)
}

export default function* root() {
  yield [
    fork(fetchMe),
    fork(fetchRecommendedZiltagMaps),
    fork(watchVerify),
    fork(watchSignOut),
    fork(watchRouterLocationChange),
    fork(watchRequestChangePassword)
  ]
}