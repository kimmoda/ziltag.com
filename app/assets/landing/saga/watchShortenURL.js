import {takeEvery} from 'redux-saga'
import {call, put} from 'redux-saga/effects'
import {createShortenURL} from '../api'
import {requestShortenURL, receiveShortenURL} from '../actions'
import {push} from 'react-router-redux'

export default function* watchShortenURL() {
  yield* takeEvery('REQUEST_SHORTEN_URL', shortenURL)
}

function* shortenURL(action){
  const response = yield call(createShortenURL, action.url)
  const {id, url} = response.data.createShortenURL
  yield put(receiveShortenURL(id, url))
  yield put(push(`/preview/${id}`))
}
