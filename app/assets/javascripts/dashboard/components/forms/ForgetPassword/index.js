import React from 'react'
import './index.scss'
import TextField from 'TextField'
import Button from 'Button'

export default props => {
  const {fields: {email}, handleSubmit, error} = props
  return (
    <form className="ziltag-forms-forget-password" onSubmit={handleSubmit}>
      <div className="ziltag-forms-forget-password__title">Forgot your password?</div>
      <div className="ziltag-forms-forget-password__subtitle">Fill in your email, we'll send you a reset instruction.</div>
      <div style={{marginTop: 50}}>
        <TextField type="email" placeholder="Email" {...email}/>
      </div>
      <div style={{marginTop: 30}}>
        <Button>Send</Button>
      </div>
      {error && <div className="ziltag-forms-forget-password__error">{error}</div>}
    </form>
  )
}
