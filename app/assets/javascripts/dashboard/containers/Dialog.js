import Dialog from '../components/Dialog'
import PasswordForm from './forms/Password'
import * as actions from '../actions'
import {connect} from 'react-redux'
import React from 'react'

function nameToForm(name){
  switch (name) {
    case 'password':
      return <PasswordForm />
    default:
      return null
  }
}

function mapStateToProps(state) {
  if (state.dialog)
    return {
      open: true,
      name: state.dialog,
      children: nameToForm(state.dialog)
    }
  else return {
    open: false
  }
}

function mapDispatchToProps(dispatch) {
  return {
    onClose: _ => dispatch(actions.closeDialog())
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(Dialog)