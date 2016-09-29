import createSagaMiddleware from 'redux-saga'
import watchSignIn from './watchSignIn'

export const sagaMiddleware = createSagaMiddleware()

export default function* () {
  yield [
    watchSignIn()
  ]
}
