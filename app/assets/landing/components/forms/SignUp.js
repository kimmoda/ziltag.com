import React, {PropTypes} from 'react'
import TextField from 'ziltag-elements/dist/TextField'
import Button from 'ziltag-elements/dist/Button'
import Form from 'ziltag-elements/dist/Form'

function SignUp(props) {
  const {
    fields: {username, email, url},
    handleSubmit, onSignIn, error,
    ...others
  } = props
  return (
    <Form
      onSubmit={handleSubmit}
      fields={[
        <TextField width="100%" placeholder="Username" {...username}/>,
        <TextField width="100%" placeholder="Email" type="email" {...email}/>,
        <TextField width="100%" placeholder="Website URL (Ex. https://example.com)" {...url}/>
      ]}
      button={<Button width="100%" text="Sign Up"/>}
      tip={<div>By signing up, you agree to our <a href="http://blog.ziltag.com/terms" target="_blank" rel="noopener">terms</a> and <a href="http://blog.ziltag.com/privacy/" target="_blank" rel="noopener">privacy policy</a>.</div>}
      footer={<div>Already have an account? <a href="javascript:void(0)" onClick={onSignIn}>Sign In</a></div>}
      error={error}
      />
  )
}

SignUp.defaultProps = {
  fields: {}
}

export default SignUp
