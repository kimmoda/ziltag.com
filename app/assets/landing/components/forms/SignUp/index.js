import React, {PropTypes} from 'react'
import TextField from 'ziltag-elements/dist/TextField'
import Button from 'ziltag-elements/dist/Button'

import './index.css'

function SignUp(props) {
  const {fields: {username, email, url}, handleSubmit, handleClickSignIn} = props
  return (
    <form className="sign-up" onSubmit={handleSubmit}>
      <div className="sign-up__fields">
        <div className="sign-up__field"><TextField width="100%" placeholder="Username" {...username}/></div>
        <div className="sign-up__field"><TextField width="100%" placeholder="Email" {...email}/></div>
        <div className="sign-up__field"><TextField width="100%" placeholder="Website URL (Ex. https://example.com)" {...url}/></div>
      </div>
      <div className="sign-up__privacy">By signing up, you agree to our <a href="http://blog.ziltag.com/terms" target="_blank" rel="noopener">terms</a> and <a href="http://blog.ziltag.com/privacy/" target="_blank" rel="noopener">privacy policy</a>.</div>
      <div className="sign-up__button"><Button text="Sign Up" width="100%"/></div>
      <div className="sign-up__footer">Already have an account? <a className="sign-up__sign-in" onClick={handleClickSignIn}>Sign In</a></div>
    </form>
  )
}

SignUp.defaultProps = {
  fields: {}
}

export default SignUp
