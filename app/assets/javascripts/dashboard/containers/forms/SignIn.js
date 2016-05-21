import SignIn from '../../components/forms/SignIn'
import * as actions from '../../actions'
import { reduxForm } from 'redux-form'

export default reduxForm({
  form: 'signIn',
  fields: ['username', 'password']
}, null, dispatch => ({
  onSubmit: params => dispatch(actions.requestSignIn(params))
}))(SignIn)