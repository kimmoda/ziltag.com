import React from 'react'
import TextField from 'ziltag-elements/dist/TextField'
import Button from 'ziltag-elements/dist/Button'
import Form from 'ziltag-elements/dist/Form'
import { reduxForm } from 'redux-form'
import {bindActionCreators} from 'redux'
import {requestVerify} from '../actions'

const Password = props => {
  const {fields: {password, password_confirmation, confirmation_token}, handleSubmit, error} = props
  return (
    <div style={{marginTop: 82, padding: '0 28px'}}>
      <Form
        title="Password Setup"
        onSubmit={handleSubmit}
        fields={[
          <TextField type="password" width="100%" placeholder="Password" {...password}/>,
          <TextField type="password" width="100%" placeholder="Confirm Password" {...password_confirmation}/>,
          <input type="hidden" {...confirmation_token}/>
        ]}
        button={<Button width="100%" text="Finish"/>}
        error={error}
        />
    </div>
  )
}

export default reduxForm({
  form: 'mobileVerify',
  fields: ['password', 'password_confirmation', 'confirmation_token']
}, mapStateToProps, mapDispatchToProps)(Password)

function mapStateToProps(state, ownProps){
  return {
    initialValues: {
      confirmation_token: ownProps.location.query.confirmation_token
    }
  }
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({
    onSubmit: verify
  }, dispatch)
}

function verify(data){
  const {password, password_confirmation, confirmation_token} = data
  return requestVerify(password, password_confirmation, confirmation_token)
}
