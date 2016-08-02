import React from 'react'
import './index.scss'
import TextField from 'TextField'
import Button from 'Button'
import { reduxForm } from 'redux-form'
import { requestResetPassword } from 'actions'

export default reduxForm({
  form: 'passwordReset',
  fields: ['password', 'password_confirmation', 'reset_password_token']
}, (state, ownProps) => ({
  initialValues: {
    reset_password_token: ownProps.location.query.reset_password_token
  }
}), dispatch => ({
  onSubmit: data => dispatch(requestResetPassword(data))
}))(props => {
  const {fields: {password, password_confirmation, reset_password_token}, handleSubmit, error} = props
  return (
    <div className="ziltag-pages-password">
      <div className="ziltag-pages-password__title">Change Your Password</div>
        <form className="ziltag-pages-password__form" onSubmit={handleSubmit}>
          <div className="ziltag-pages-password__fields">
            <div className="ziltag-pages-password__field">
              <TextField required type="password" placeholder="PASSWORD" {...password}/>
            </div>
            <div className="ziltag-pages-password__field">
              <TextField required type="password" placeholder="CONFIRM PASSWORD" {...password_confirmation}/>
            </div>
          </div>
          <input type="hidden" {...reset_password_token}/>
          <div className="ziltag-pages-password__button">
            <Button>OK</Button>
          </div>
          {error && <div className="ziltag-pages-password__error">{error}</div>}
        </form>
    </div>
  )
})
