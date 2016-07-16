import Dialog from '../components/Dialog'
import DialogSuccess from '../components/DialogSuccess'
import PasswordForm from './forms/Password'
import DomainForm from './forms/Domain'
import SignIn from './forms/SignIn'
import SignUp from './forms/SignUp'
import UpdateDomainForm from './forms/UpdateDomain'
import DeleteWebsite from './DeleteWebsite'
import * as actions from '../actions'
import {connect} from 'react-redux'
import React from 'react'
import InstallPlugin from './forms/InstallPlugin'

function nameToForm(name){
  switch (name) {
    case 'password':
      return <PasswordForm/>
    case 'password_changed':
      return <DialogSuccess message="Password changed!"/>
    case 'addDomain':
      return <DomainForm/>
    case 'domainAdded':
      return <DialogSuccess message="Domain added!" />
    case 'deleteWebsite':
      return <DeleteWebsite />
    case 'domainDeleted':
      return <DialogSuccess message="Domain deleted!" />
    case 'updateWebsite':
      return <UpdateDomainForm/>
    case 'domainUpdated':
      return <DialogSuccess message="Domain updated!" />
    case 'signIn':
      return <SignIn/>
    case 'signUp':
      return <SignUp/>
    case 'installPlugin':
      return <InstallPlugin />
    default:
      return null
  }
}

function mapStateToProps(state) {
  if (state.dialog)
    return {
      open: true,
      name: state.dialog.name,
      children: nameToForm(state.dialog.name),
      payload: state.dialog.payload
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
