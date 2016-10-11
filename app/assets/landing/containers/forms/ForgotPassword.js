import {reduxForm} from 'redux-form'
import {requestForgotPassword} from '../../actions'
import {bindActionCreators} from 'redux'
import ForgotPassword from '../../components/forms/ForgotPassword'

export default reduxForm({
  form: 'forgotPassword',
  fields: ['email']
}, null, mapDispatchToProps)(ForgotPassword)

function mapDispatchToProps(dispatch) {
  return bindActionCreators({
    onSubmit: forgotPassword
  }, dispatch)
}


function forgotPassword(params){
  const {email} = params
  return requestForgotPassword(email)
}
