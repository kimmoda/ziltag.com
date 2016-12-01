import {takeEvery} from 'redux-saga'
import {call, put} from 'redux-saga/effects'
import {sendDemoLink} from '../api'
import {push} from 'react-router-redux'

export default function* () {
  yield* takeEvery('REQUEST_DEMO_LINK', requestSendDemoLink)
}

function* requestSendDemoLink(action){
  yield call(sendDemoLink, action.email, action.preview_id)
  yield put(push('/m/sent_demo_link'))
}
