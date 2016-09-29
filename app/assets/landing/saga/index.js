import createSagaMiddleware from 'redux-saga'
import watchSignIn from './watchSignIn'
import watchSignUp from './watchSignUp'

export const sagaMiddleware = createSagaMiddleware()

export default function* () {
  yield [
    watchSignIn(),
    watchSignUp()
  ]
}
