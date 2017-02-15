import {takeEvery, call, put} from 'redux-saga/effects'
import {verify} from '../api'
import {failVerify} from '../actions'
import {push} from 'react-router-redux'

export default function* () {
  yield takeEvery('REQUEST_VERIFY', requestVerify)
}

function* requestVerify(action){
  const {password, password_confirmation, confirmation_token} = action
  const response = yield call(verify, password, password_confirmation, confirmation_token)
  if(response.errors) yield put(failVerify(response.errors[0].message))
  else {
    yield put(push('/m/verified/'))
  }
}
