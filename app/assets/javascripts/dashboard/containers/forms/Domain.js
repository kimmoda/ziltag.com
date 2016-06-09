import DomainForm from '../../components/forms/Domain'
import * as actions from '../../actions'
import { connect } from 'react-redux'
import { reduxForm } from 'redux-form'

function mapDispatchToProps(dispatch) {
  return {
    onSubmit: params => dispatch(actions.requestAddWebsite(params.url))
  }
}

export default reduxForm({
  form: 'domain',
  fields: ['url'],
}, null, mapDispatchToProps)(DomainForm)