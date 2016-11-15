import {takeLatest, delay} from 'redux-saga'
import {put} from 'redux-saga/effects'
import {closeSnackBar} from '../actions'

export default function* () {
  yield* takeLatest('SHOW_IFRAME', delayClose)
}

function* delayClose(){
  yield delay(30000)
  yield put(closeSnackBar())
}
