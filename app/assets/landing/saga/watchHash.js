import {put} from 'redux-saga/effects'
import {openModal} from '../actions'

export default function* (){
  const hash = location.hash.substr(1)
  if(hash == 'signIn' || hash == 'signUp') {
    yield put(openModal(hash))
  }
}
