import DomainForm from '../../components/forms/Domain'
import * as actions from '../../actions'
import { connect } from 'react-redux'
import { reduxForm } from 'redux-form'

function mapDispatchToProps(dispatch) {
  return {
    onSubmit: params => dispatch(actions.requestAddWebsite(params))
  }
}

export default reduxForm({
  form: 'domain',
  fields: ['platform', 'url', 'tumblr', 'blogger'],
  initialValues: {
    platform: 'general'
  }
}, null, mapDispatchToProps)(DomainForm)