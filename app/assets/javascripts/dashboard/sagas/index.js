import * as actionTypes from '../actions/types'
import * as actions from '../actions'
import * as API from '../apis'
import {user, ziltagMap, website} from '../schema'
import { takeEvery, takeLatest, eventChannel } from 'redux-saga'
import { take, call, put, fork, cancel } from 'redux-saga/effects'
import { push } from 'react-router-redux'
import { normalize, arrayOf } from 'normalizr'

function windowMessageChannel(){
  return eventChannel(listener => {
    const callback = ({data}) => listener(data)
    window.addEventListener('message', callback)
    return _ => window.removeEventListener('message', callback)
  })
}

export function* watchWindowMessage(){
  const channel = yield call(windowMessageChannel)
  while(true){
    const data = yield take(channel)
    if(data == 'deactivate_ziltag_reader') yield put(actions.closeModal())
  }
}

function windowResizeChannel(){
  return eventChannel(listener => {
    const callback = event => listener({width: event.target.innerWidth, height: event.target.innerHeight})
    window.addEventListener('resize', callback)
    return _ => window.removeEventListener('resize', callback)
  })
}

export function* watchWindowSize(){
  const channel = yield call(windowResizeChannel)
  while(true) {
    const result = yield take(channel)
    yield put(actions.resizeWindow(result.width, result.height))
  }
}


function delay(ms){
  return new Promise(resolve => setTimeout(resolve, ms))
}

function* fetchMe() {
  const response = yield call(API.fetchMe)
  yield put({type: actionTypes.RECEIVE_ME, response: normalize(response.data.me || {}, user)})
}

function* watchFetchMe() {
  yield* takeEvery(actionTypes.REQUEST_ME, fetchMe)
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
    yield put(push('/dashboard/verified'))
    yield put(actions.me())
    yield put({type: actionTypes.REQUEST_VERIFY_SUCCEEDED})
  }
}

function* watchVerify() {
  yield* takeEvery(actionTypes.REQUEST_VERIFY, verify)
}

function* signOut(action){
  try {
    yield call(API.sign_out)
    window.location.replace('/')
  } catch (e) {
  }
}

function* watchSignOut() {
  yield* takeEvery(actionTypes.REQUEST_SIGN_OUT, signOut)
}

function* redirectToRoot() {
  yield call(delay, 5000)
  yield put(push('/dashboard'))
}

function* watchRouterLocationChange() {
  let lastTask
  while(true) {
    const action = yield take('@@router/LOCATION_CHANGE')
    if(action.payload.pathname == '/dashboard/verified'){
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

function* requestSignIn(action){
  const response = yield call(API.signIn, action.username, action.password)
  if(response.errors) yield put(actions.receiveSignInError(response.errors))
  else{
    yield put(actions.receiveSignIn(response))
    yield put(actions.closeDialog())
    yield put(actions.me())
    yield put(push('/dashboard'))
  }
}

function* watchRequestSignIn(){
  yield* takeEvery(actionTypes.REQUEST_SIGN_IN, requestSignIn)
}

function* partnerSignUp(action){
  const response = yield call(API.partnerSignUp, action.username, action.email, action.url)
  if(response.errors) yield put(actions.receivePartnerSignUpError(response.errors))
  else {
    yield put(actions.receivePartnerSignUp())
    yield put(actions.closeDialog())
    yield put(actions.me())
    yield put(push('/dashboard/install'))
  }
}

function* watchParterSignUp(){
  yield* takeEvery(actionTypes.REQUEST_PARTNER_SIGN_UP, partnerSignUp)
}

function* uploadAvatar(action){
  const response = yield call(API.uploadAvatar, action.file)
  if(response.errors); // TODO
  else yield put(actions.receiveAvatar(response.data.uploadAvatar))
}

function* watchUploadAvatar(){
  yield* takeEvery(actionTypes.UPLOAD_AVATAR, uploadAvatar)
}

function* watchRequestRecommendedZiltagMaps(){
  yield* takeEvery(actionTypes.RETRIEVE_RECOMMENDED_ZILTAG_MAPS, fetchRecommendedZiltagMaps)
}

function* upgradeUser(action){
  const response = yield call(API.upgradeUser, action.url)
  if(response.errors) yield put(actions.receiveUpgradeUserError(response.errors))
  else {
    yield put(actions.closeDialog())
    yield put(actions.me())
    yield put(push('/dashboard/install'))
  }
}

function* watchUpgradeUser(){
  yield* takeLatest(actionTypes.REQUEST_UPGRADE_USER, upgradeUser)
}

function* requestUpdateWebsitePermission(action){
  const response = yield call(API.updateWebsitePermission, action.id, action.restricted)
  if(response.errors); // TODO
  else {
    yield put(actions.receiveUpdateWebsitePermission(response.data.updateWebsitePermission))
  }
}

function* watchRequestUpdateWebsitePermission(){
  yield* takeEvery(actionTypes.REQUEST_UPDATE_WEBSITE_PERMISSION, requestUpdateWebsitePermission)
}

function* requestUpdateZiltagNotification(action){
  const response = yield call(API.updateZiltagNotification, action.ziltagNotification)
  if(response.errors);
  else yield put(actions.receiveUpdateZiltagNotification(response.data.updateZiltagNotification))
}

function* watchRequestUpdateZiltagNotification(){
  yield* takeEvery(actionTypes.REQUEST_UPDATE_ZILTAG_NOTIFICATION, requestUpdateZiltagNotification)
}

function* requestUpdateCommentNotification(action){
  const response = yield call(API.updateCommentNotification, action.commentNotification)
  if(response.errors);
  else yield put(actions.receiveUpdateCommentNotification(response.data.updateCommentNotification))
}

function* watchRequestUpdateCommentNotification(){
  yield* takeEvery(actionTypes.REQUEST_UPDATE_COMMENT_NOTIFICATION, requestUpdateCommentNotification)
}

function* requestResetPassword(action){
  const {password, passwordConfirmation, resetPasswordToken} = action
  const response = yield call(API.resetPassword, password, passwordConfirmation, resetPasswordToken)
  if(response.errors)
    yield put(actions.receiveResetPasswordError(response.errors))
  else {
    yield put(push('/dashboard/account'))
    yield put(actions.me())
  }
}

function* watchRequestResetPassword(){
  yield* takeLatest(actionTypes.REQUEST_RESET_PASSWORD, requestResetPassword)
}

export default function* root() {
  yield [
    watchWindowMessage(),
    watchWindowSize(),
    fetchMe(),
    watchFetchMe(),
    watchVerify(),
    watchSignOut(),
    watchRouterLocationChange(),
    watchRequestChangePassword(),
    watchRequestAddWebsite(),
    watchRequestDeleteWebsite(),
    watchRequestUpdateWebsite(),
    watchRequestSignIn(),
    watchParterSignUp(),
    watchUploadAvatar(),
    watchRequestRecommendedZiltagMaps(),
    watchUpgradeUser(),
    watchRequestUpdateWebsitePermission(),
    watchRequestUpdateZiltagNotification(),
    watchRequestUpdateCommentNotification(),
    watchRequestResetPassword()
  ]
}
