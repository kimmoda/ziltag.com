import SignUp from '../../components/forms/SignUp'
import * as actions from '../../actions'
import { reduxForm } from 'redux-form'

export default reduxForm({
  form: 'signUp',
  fields: ['username', 'email', 'url']
}, null, dispatch => ({
  onSubmit: ({username, email, url}) => dispatch(actions.requestPartnerSignUp(username, email, url))
}))(SignUp)