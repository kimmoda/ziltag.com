import PasswordForm from '../../components/forms/Password'
import * as actions from '../../actions'
import { connect } from 'react-redux'
import { reduxForm } from 'redux-form'

function mapDispatchToProps(dispatch) {
  return {
    onSubmit: params => dispatch(actions.requestChangePassword(params))
  }
}

export default reduxForm({
  form: 'password',
  fields: ['oldPassword', 'newPassword', 'confirmPassword'],
}, null, mapDispatchToProps)(PasswordForm);