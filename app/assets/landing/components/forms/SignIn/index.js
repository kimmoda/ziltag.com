import React from 'react'
import Form from 'ziltag-elements/dist/Form'
import TextField from 'ziltag-elements/dist/TextField'
import Button from 'ziltag-elements/dist/Button'

function SignIn(props) {
  const {
    fields: {username, password},
    handleSubmit, onForgotPassword, onSignUp, error,
    ...others
  } = props
  return (
    <Form
      onSubmit={handleSubmit}
      fields={[
        <TextField width="100%" placeholder="Username or Email" {...username}/>,
        <TextField width="100%" placeholder="Password" type="password" {...password}/>
      ]}
      button={<Button width="100%" text="Sign In"/>}
      tip={<a href="javascript:void(0)" onClick={onForgotPassword}>Forgot Password?</a>}
      footer={<div>Don’t have an account? <a href="javascript:void(0)" onClick={onSignUp}>Sign Up</a></div>}
      error={error}
      />
  )
}

SignIn.defaultProps = {
  fields: {}
}

export default SignIn
