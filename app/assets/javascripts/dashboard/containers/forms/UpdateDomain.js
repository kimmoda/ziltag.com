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
    requestUpdateWebsite: (id, params) => dispatch(actions.requestUpdateWebsite(id, params))
  }
}

function mergeProps(stateProps, dispatchProps, ownProps) {
  return Object.assign({}, ownProps, stateProps, dispatchProps, {
    onSubmit: params => dispatchProps.requestUpdateWebsite(stateProps.id, params)
  })
}


export default reduxForm({
  form: 'domain',
  fields: ['platform', 'url', 'tumblr', 'blogger'],
  initialValues: {
    platform: 'general'
  }
}, mapStateToProps, mapDispatchToProps, mergeProps)(DomainForm)