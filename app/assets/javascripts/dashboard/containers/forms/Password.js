import PasswordForm from '../../components/forms/Password'
import { connect } from 'react-redux'
import { reduxForm } from 'redux-form'

export default reduxForm({
  form: 'password',
  fields: ['oldPassword', 'newPassword', 'confirmPassword'],
  onSubmit: _ => _
})(PasswordForm);