import {takeEvery} from 'redux-saga'
import {call, put} from 'redux-saga/effects'
import {signUp} from '../api'
import {failSignUp} from '../actions'

export default function* () {
  yield* takeEvery('REQUEST_SIGN_UP', requestSignUp)
}

function* requestSignUp(action){
  const {username, email, url} = action
  const response = yield call(signUp, username, email, url)
  if(response.errors) yield put(failSignUp(response.errors[0].message))
  else yield window.location = '/dashboard/install'
}
