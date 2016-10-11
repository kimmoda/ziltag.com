import createSagaMiddleware from 'redux-saga'
import watchSignIn from './watchSignIn'
import watchSignUp from './watchSignUp'
import watchForgotPassword from './watchForgotPassword'

export const sagaMiddleware = createSagaMiddleware()

export default function* () {
  yield [
    watchSignIn(),
    watchSignUp(),
    watchForgotPassword()
  ]
}
