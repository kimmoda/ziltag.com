import createSagaMiddleware from 'redux-saga'
import watchSignIn from './watchSignIn'
import watchSignUp from './watchSignUp'
import watchForgotPassword from './watchForgotPassword'
import watchMessage from './watchMessage'

export const sagaMiddleware = createSagaMiddleware()

export default function* () {
  yield [
    watchSignIn(),
    watchSignUp(),
    watchForgotPassword(),
    watchMessage()
  ]
}
