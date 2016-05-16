import AskBoard from '../components/AskBoard'
import {connect} from 'react-redux'
import * as actions from '../actions'
import React from 'react'

const DeleteWebsite = props => (
  <AskBoard question="Are you sure you want to delete?" {...props} />
)

function mapStateToProps(state) {
  return {
    payload: state.dialog.payload
  }
}

function mapDispatchToProps(dispatch) {
  return {
    onYes: id => dispatch(actions.requestDeleteWebsite(id)),
    onNo: id => dispatch(actions.closeDialog())
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(DeleteWebsite)