import SignUp from '../../components/forms/SignUp'
import {reduxForm} from 'redux-form'

export default reduxForm({
  form: 'signUp',
  fields: ['username', 'email', 'url']
}, null, mapDispatchToProps)(SignUp)

function mapDispatchToProps(dispatch) {
  return {
    onSubmit: (params) => console.log(params)
  }
}
