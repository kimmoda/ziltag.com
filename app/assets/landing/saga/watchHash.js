import {put} from 'redux-saga/effects'
import {openModal} from '../actions'

export default function* (){
  const hash = location.hash.substr(1)
  yield put(openModal(hash))
}
