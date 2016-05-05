import Dialog from '../components/Dialog'
import PasswordChanged from '../components/PasswordChanged'
import PasswordForm from './forms/Password'
import * as actions from '../actions'
import {connect} from 'react-redux'
import React from 'react'

function nameToForm(name){
  switch (name) {
    case 'password':
      return <PasswordForm />
    case 'password_changed':
      return <PasswordChanged />
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