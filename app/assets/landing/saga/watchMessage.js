import {eventChannel} from 'redux-saga'
import {call, take, put} from 'redux-saga/effects'
import {hoverIn, hoverOut, readerOpened, readerClosed, inputOpened} from '../actions'

function message() {
  return eventChannel(emitter => {
    const handleMessage = event => {
      if(event.origin !== 'https://preview.ziltag.com') return
      emitter(event)
    }
    window.addEventListener('message', handleMessage)
    return () => {
      window.removeEventListener('message', handleMessage)
    }
  })
}

export default function* watchMessage() {
  const channel = yield call(message)
  while (true) {
    let event = yield take(channel)
    switch (event.data) {
    case 'ZILTAG_MAP_SWITCH_ACTIVATED':
      yield put(hoverIn())
      break
    case 'ZILTAG_MAP_SWITCH_DEACTIVATED':
      yield put(hoverOut())
      break
    case 'ZILTAG_READER_ACTIVATED':
      yield put(readerOpened())
      break
    case 'ZILTAG_READER_DEACTIVATED':
      yield put(readerClosed())
      break
    case 'ZILTAG_INPUT_ACTIVATED':
      yield put(inputOpened())
      break
    }
  }
}
