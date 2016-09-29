import {reduxForm} from 'redux-form'
import {openModal} from '../../actions'
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
    onSubmit: params => console.log(params)
  }, dispatch)
}

function signUp(){
  return openModal('signUp')
}

function forgotPassword(){
  return openModal('forgotPassword')
}
