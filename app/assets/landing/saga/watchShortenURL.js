import {takeEvery} from 'redux-saga'
import {call, put} from 'redux-saga/effects'
import {findOrCreateShortenURL} from '../api'
import {requestShortenURL, receiveShortenURL} from '../actions'

export default function* watchShortenURL() {
  yield* takeEvery('REQUEST_SHORTEN_URL', shortenURL)
}

function* shortenURL(action){
  const response = yield call(findOrCreateShortenURL, action.url)
  const {id, url} = response.data.findOrCreateShortenURL
  yield put(receiveShortenURL(id, url))
}
