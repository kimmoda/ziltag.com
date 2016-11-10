import {takeEvery} from 'redux-saga'
import {call, put, select} from 'redux-saga/effects'
import {signUp} from '../api'
import {failSignUp} from '../actions'
import {push} from 'react-router-redux'

export default function* () {
  yield* takeEvery('REQUEST_SIGN_UP', requestSignUp)
}

function* requestSignUp(action){
  const {username, email, url} = action
  const response = yield call(signUp, username, email, url)
  if(response.errors) yield put(failSignUp(response.errors[0].message))
  else {
    const state = yield select()
    console.log(state)
    if(state.window.width <= 650) yield put(push('/m/signed_up/'))
    else window.location = '/dashboard/install'
  }
}
