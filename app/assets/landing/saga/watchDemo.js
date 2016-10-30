import {takeLatest, delay} from 'redux-saga'
import {put} from 'redux-saga/effects'
import {closeSnackBar} from '../actions'

export default function* () {
  yield* takeLatest('SHOW_IFRAME', delayClose)
}

function* delayClose(action){
  yield delay(5000)
  yield put(closeSnackBar())
}
