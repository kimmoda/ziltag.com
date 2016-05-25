import SignUp from '../../components/forms/SignUp'
import * as actions from '../../actions'
import { reduxForm } from 'redux-form'

export default reduxForm({
  form: 'signUp',
  fields: ['username', 'email', 'platform', 'url', 'tumblr', 'blogger'],
  initialValues: {
    platform: 'general'
  }
}, null, dispatch => ({
  onSubmit: params => dispatch(actions.requestPartnerSignUp(params))
}))(SignUp)