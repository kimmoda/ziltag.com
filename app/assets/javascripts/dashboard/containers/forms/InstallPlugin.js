import { reduxForm } from 'redux-form'
import InstallPlugin from '../../components/forms/InstallPlugin'
import {requestUpgradeUser} from 'actions'

export default reduxForm({
  form: 'installPlugin',
  fields: ['url']
}, null, dispatch => ({
  onSubmit: params => dispatch(requestUpgradeUser(params.url))
}))(InstallPlugin)
