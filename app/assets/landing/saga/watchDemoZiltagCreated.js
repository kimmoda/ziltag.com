import {takeEvery, delay} from 'redux-saga'
import {put} from 'redux-saga/effects'
import {disableTip} from '../actions'

export default function* () {
  yield* takeEvery('DEMO_ZILTAG_CREATED', delayDisableTip)
}

function* delayDisableTip(){
  yield delay(30000)
  yield put(disableTip())
}
