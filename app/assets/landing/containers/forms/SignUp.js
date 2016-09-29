import SignUp from '../../components/forms/SignUp'
import {openModal, requestSignUp} from '../../actions'
import {bindActionCreators} from 'redux'
import {reduxForm} from 'redux-form'

export default reduxForm({
  form: 'signUp',
  fields: ['username', 'email', 'url']
}, null, mapDispatchToProps)(SignUp)

function mapDispatchToProps(dispatch) {
  return bindActionCreators({
    onSignIn: signIn,
    onSubmit: signUp
  }, dispatch)
}

function signIn(){
  return openModal('signIn')
}

function signUp(params){
  const {username, email, url} = params
  return requestSignUp(username, email, url)
}
