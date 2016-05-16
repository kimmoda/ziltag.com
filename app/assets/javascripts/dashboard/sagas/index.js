import * as actionTypes from '../actions/types'
import * as actions from '../actions'
import * as API from '../apis'
import {user, ziltagMap, website} from '../schema'
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

function* requestAddWebsite(action) {
  const url = action.url
  const response = yield call(API.createWebsite, url)
  if(response.errors); // TODO
  else {
    yield put({type: actionTypes.RECEIVE_ADD_WEBSITE, response: normalize(response.data.createWebsite, website)})
    yield put(actions.openDialog('domainAdded'))
  }
}

function* watchRequestAddWebsite() {
  yield* takeEvery(actionTypes.REQUEST_ADD_WEBSITE, requestAddWebsite)
}

function* requestDeleteWebsite(action){
  const response = yield call(API.deleteWebsite, action.id)
  yield put(actions.receiveDeleteWebsite(action.id))
  yield put(actions.openDialog('domainDeleted'))
}

function* watchRequestDeleteWebsite(){
  yield* takeEvery(actionTypes.REQUEST_DELETE_WEBSITE, requestDeleteWebsite)
}

function* requestUpdateWebsite(action){
  const response = yield call(API.updateWebsite, action.id, action.url)
  if(response.errors); // TODO
  else {
    yield put(actions.receiveUpdateWebsite(response.data.updateWebsite))
    yield put(actions.openDialog('domainUpdated'))
  }
}

function* watchRequestUpdateWebsite(){
  yield* takeEvery(actionTypes.REQUEST_UPDATE_WEBSITE, requestUpdateWebsite)
}

export default function* root() {
  yield [
    fetchMe(),
    fetchRecommendedZiltagMaps(),
    watchVerify(),
    watchSignOut(),
    watchRouterLocationChange(),
    watchRequestChangePassword(),
    watchRequestAddWebsite(),
    watchRequestDeleteWebsite(),
    watchRequestUpdateWebsite()
  ]
}