import {put} from 'redux-saga/effects'

export default function* (){
  yield put({type: 'SET_WINDOW', width: window.innerWidth})
}
