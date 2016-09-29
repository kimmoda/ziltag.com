import SignUp from '../../components/forms/SignUp'
import {openModal} from '../../actions'
import {bindActionCreators} from 'redux'
import {reduxForm} from 'redux-form'

export default reduxForm({
  form: 'signUp',
  fields: ['username', 'email', 'url']
}, null, mapDispatchToProps)(SignUp)

function mapDispatchToProps(dispatch) {
  return bindActionCreators({
    onSignIn: signIn,
    onSubmit: params => console.log(params)
  }, dispatch)
}

function signIn(){
  return openModal('signIn')
}
