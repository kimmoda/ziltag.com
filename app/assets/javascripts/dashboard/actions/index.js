import * as actionTypes from './types'
import { normalize } from 'normalizr'
import { website as websiteType, user as userType } from '../schema'

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

export function requestAddWebsite(url) {
  return {
    type: actionTypes.REQUEST_ADD_WEBSITE,
    url
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

export function requestUpdateWebsite(id, url){
  return {
    type: actionTypes.REQUEST_UPDATE_WEBSITE,
    id, url
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

export function requestPartnerSignUp(username, email, url){
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

export function playVideoLayer(){
  return {
    type: actionTypes.PLAY_VIDEO_LAYER
  }
}
export function pauseVideoLayer(){
  return {
    type: actionTypes.PAUSE_VIDEO_LAYER
  }
}
export function endVideoLayer(){
  return {
    type: actionTypes.END_VIDEO_LAYER
  }
}

export function openVideoLayer(videoID){
  return {
    type: actionTypes.OPEN_VIDEO_LAYER,
    videoID
  }
}

export function closeVideoLayer(){
  return {
    type: actionTypes.CLOSE_VIDEO_LAYER
  }
}

export function resizeWindow(width, height){
  return {
    type: actionTypes.RESIZE_WINDOW,
    width,
    height
  }
}

export function closeModal(){
  return {
    type: actionTypes.CLOSE_MODAL
  }
}

export function uploadAvatar(file) {
  return {
    type: actionTypes.UPLOAD_AVATAR,
    file
  }
}

export function receiveAvatar(response) {
  return {
    type: actionTypes.RECEIVE_AVATAR,
    response: normalize(response, userType)
  }
}

export function retrieveRecommendedZiltagMaps(){
  return {
    type: actionTypes.RETRIEVE_RECOMMENDED_ZILTAG_MAPS
  }
}

export function requestUpgradeUser(url){
  return {
    type: actionTypes.REQUEST_UPGRADE_USER,
    url
  }
}

export function receiveUpgradeUserError(errors) {
  return {
    type: actionTypes.RECEIVE_UPGRADE_USER_ERROR,
    errors
  }
}

export function requestUpdateWebsitePermission(id, restricted){
  return {
    type: actionTypes.REQUEST_UPDATE_WEBSITE_PERMISSION,
    id, restricted
  }
}

export function receiveUpdateWebsitePermission(website){
  return {
    type: actionTypes.RECEIVE_UPDATE_WEBSITE_PERMISSION,
    response: normalize(website, websiteType)
  }
}

export function requestUpdateZiltagNotification(ziltagNotification){
  return {
    type: actionTypes.REQUEST_UPDATE_ZILTAG_NOTIFICATION,
    ziltagNotification
  }
}

export function receiveUpdateZiltagNotification(user){
  return {
    type: actionTypes.RECEIVE_UPDATE_ZILTAG_NOTIFICATION,
    response: normalize(user, userType)
  }
}

export function requestUpdateCommentNotification(commentNotification){
  return {
    type: actionTypes.REQUEST_UPDATE_COMMENT_NOTIFICATION,
    commentNotification
  }
}

export function receiveUpdateCommentNotification(user){
  return {
    type: actionTypes.RECEIVE_UPDATE_COMMENT_NOTIFICATION,
    response: normalize(user, userType)
  }
}

export function requestResetPassword(data){
  const {
    password,
    password_confirmation: passwordConfirmation,
    reset_password_token: resetPasswordToken
  } = data
  return {
    type: actionTypes.REQUEST_RESET_PASSWORD,
    password, passwordConfirmation, resetPasswordToken
  }
}

export function receiveResetPasswordError(errors){
  return {
    type: actionTypes.RECEIVE_RESET_PASSWORD_ERROR,
    error: errors[0].message
  }
}

export function requestForgotPassword(email){
  return {
    type: actionTypes.REQUEST_FORGOT_PASSWORD,
    email
  }
}

export function receiveForgotPasswordError(errors){
  return {
    type: actionTypes.RECEIVE_FORGOT_PASSWORD_ERROR,
    error: errors[0].message
  }
}

export function requestSubscribe(token){
  return {
    type: actionTypes.REQUEST_SUBSCRIBE,
    token
  }
}

export function receiveSubscribe() {
  return {
    type: actionTypes.RECEIVE_SUBSCRIBE
  }
}

export function receiveSubscribeError(errors) {
  return {
    type: actionTypes.RECEIVE_SUBSCRIBE_ERROR,
    error: errors[0].message
  }
}
