import {takeEvery} from 'redux-saga'
import {call, put} from 'redux-saga/effects'
import {signIn} from '../api'
import {failSignIn} from '../actions'

export default function* () {
  yield* takeEvery('REQUEST_SIGN_IN', requestSignIn)
}

function* requestSignIn(action){
  const response = yield call(signIn, action.username, action.password)
  if(response.errors) yield put(failSignIn(response.errors[0].message))
  else yield window.location = '/dashboard'
}
