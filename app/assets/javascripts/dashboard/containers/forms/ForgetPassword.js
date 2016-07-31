import ForgetPassword from '../../components/forms/ForgetPassword'
import { reduxForm } from 'redux-form'

export default reduxForm({
  form: 'forgetPassword',
  fields: ['email'],
})(ForgetPassword)
