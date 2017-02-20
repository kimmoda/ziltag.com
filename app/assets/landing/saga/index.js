import createSagaMiddleware from 'redux-saga'
import setWindow from './setWindow'
import watchSignIn from './watchSignIn'
import watchSignUp from './watchSignUp'
import watchForgotPassword from './watchForgotPassword'
import watchMessage from './watchMessage'
import watchShortenURL from './watchShortenURL'
import watchVerify from './watchVerify'
import watchDemoZiltagCreated from './watchDemoZiltagCreated'
import watchSendDemoLink from './watchSendDemoLink'
import watchHash from './watchHash'

export const sagaMiddleware = createSagaMiddleware()

export default function* () {
  yield [
    setWindow(),
    watchSignIn(),
    watchSignUp(),
    watchForgotPassword(),
    watchMessage(),
    watchShortenURL(),
    watchVerify(),
    watchDemoZiltagCreated(),
    watchSendDemoLink(),
    watchHash()
  ]
}
