import ForgotPassword from '../../components/forms/ForgotPassword'
import { reduxForm } from 'redux-form'
import { requestForgotPassword } from 'actions'

export default reduxForm({
  form: 'forgotPassword',
  fields: ['email'],
}, null, dispatch => ({
  onSubmit: data => dispatch(requestForgotPassword(data.email))
}))(ForgotPassword)
