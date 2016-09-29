import {reduxForm} from 'redux-form'
import {openModal, requestSignIn} from '../../actions'
import {bindActionCreators} from 'redux'
import SignIn from '../../components/forms/SignIn'

export default reduxForm({
  form: 'signIn',
  fields: ['username', 'password']
}, null, mapDispatchToProps)(SignIn)

function mapDispatchToProps(dispatch) {
  return bindActionCreators({
    onSignUp: signUp,
    onForgotPassword: forgotPassword,
    onSubmit: signIn
  }, dispatch)
}

function signUp(){
  return openModal('signUp')
}

function forgotPassword(){
  return openModal('forgotPassword')
}

function signIn(params){
  const {username, password} = params
  return requestSignIn(username, password)
}
