import React from 'react'
import Field from '../../TextField'
import Button from '../../Button'
import './index.scss'

export default props => {
  const {fields: {username, password}, handleSubmit, error} = props
  return (
    <form className="ziltag-form-sign-in" onSubmit={handleSubmit}>
      <div className="ziltag-form-sign-in__fields">
        <div className="ziltag-form-sign-in__field">
          <Field required placeholder="USERNAME" {...username}/>
        </div>
        <div className="ziltag-form-sign-in__field">
          <Field required placeholder="PASSWORD" type="password" {...password}/>
        </div>
      </div>
      <div className="ziltag-form-sign-in__button">
        <div className="ziltag-form-sign-in__error">{error}</div>
        <Button>SIGN IN</Button>
      </div>
    </form>
  )
}