import ForgetPassword from '../../components/forms/ForgetPassword'
import { reduxForm } from 'redux-form'
import { requestForgetPassword } from 'actions'

export default reduxForm({
  form: 'forgetPassword',
  fields: ['email'],
}, null, dispatch => ({
  onSubmit: data => dispatch(requestForgetPassword(data.email))
}))(ForgetPassword)
