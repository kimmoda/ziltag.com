import React from 'react'
import Form from 'ziltag-elements/dist/Form'
import TextField from 'ziltag-elements/dist/TextField'
import Button from 'ziltag-elements/dist/Button'

function ForgotPassword(props) {
  const {
    fields: {email}, handleSubmit, error
  } = props
  return (
    <Form
      onSubmit={handleSubmit}
      fields={[
        <TextField width="100%" placeholder="Email" {...email} type="email"/>,
      ]}
      button={<Button width="100%" text="Send"/>}
      tip="We'll send you a password reset instruction."
      error={error}
      />
  )
}

ForgotPassword.defaultProps = {
  fields: {}
}

export default ForgotPassword
