import DomainForm from '../../components/forms/Domain'
import * as actions from '../../actions'
import { connect } from 'react-redux'
import { reduxForm } from 'redux-form'

function mapStateToProps(state) {
  const {id, url} = state.dialog.payload
  return {
    action: 'update',
    id, url
  }
}

function mapDispatchToProps(dispatch) {
  return {
    requestUpdateWebsite: (id, url) => dispatch(actions.requestUpdateWebsite(id, url))
  }
}

function mergeProps(stateProps, dispatchProps, ownProps) {
  return Object.assign({}, ownProps, stateProps, dispatchProps, {
    onSubmit: params => dispatchProps.requestUpdateWebsite(stateProps.id, params.url)
  })
}


export default reduxForm({
  form: 'domain',
  fields: ['url']
}, mapStateToProps, mapDispatchToProps, mergeProps)(DomainForm)