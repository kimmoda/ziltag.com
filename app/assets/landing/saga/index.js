import createSagaMiddleware from 'redux-saga'
import setWindow from './setWindow'
import watchSignIn from './watchSignIn'
import watchSignUp from './watchSignUp'
import watchForgotPassword from './watchForgotPassword'
import watchMessage from './watchMessage'
import watchDemo from './watchDemo'
import watchShortenURL from './watchShortenURL'
import watchVerify from './watchVerify'
import watchDemoZiltagCreated from './watchDemoZiltagCreated'

export const sagaMiddleware = createSagaMiddleware()

export default function* () {
  yield [
    setWindow(),
    watchSignIn(),
    watchSignUp(),
    watchForgotPassword(),
    watchMessage(),
    watchDemo(),
    watchShortenURL(),
    watchVerify(),
    watchDemoZiltagCreated()
  ]
}
