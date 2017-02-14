import {takeEvery, call, put, select} from 'redux-saga/effects'
import {createShortenURL} from '../api'
import {requestShortenURL, receiveShortenURL, openModal} from '../actions'
import {push} from 'react-router-redux'

export default function* watchShortenURL() {
  yield* takeEvery('REQUEST_SHORTEN_URL', shortenURL)
}

function* shortenURL(action){
  const response = yield call(createShortenURL, action.url)
  const {id, url} = response.data.createShortenURL
  const state = yield select()
  if(state.isMobile) {
    yield put(push(`/m/demo?preview=${encodeURIComponent(id)}`))
  } else {
    yield put(receiveShortenURL(id, url))
    yield put(openModal('demoGreeting', {
      size: 'small',
      showClose: false,
      overlayClose: false
    }))
    yield put(push(`/preview/${id}`))
  }
}
