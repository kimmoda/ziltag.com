import React from 'react'
import DomainFields from '../DomainFields'
import Field from '../../TextField'
import Button from '../../Button'
import './index.scss'

export default props => {
  const {fields: {username, email, url}, handleSubmit, error} = props
  return (
    <form className="ziltag-form-sign-up" onSubmit={handleSubmit}>
      <div className="ziltag-form-sign-up__title">Partner Account Information</div>
      <div className="ziltag-form-sign-up__fields">
        <div className="ziltag-form-sign-up__field">
          <Field required placeholder="USERNAME" {...username} />
        </div>
        <div className="ziltag-form-sign-up__field">
          <Field required placeholder="EMAIL" type="email" {...email} />
        </div>
        <div className="ziltag-form-sign-up__field">
          <Field required placeholder="WEBSITE URL (ex. http://example.com)" {...url} />
        </div>
      </div>
      <div className="ziltag-form-sign-up__note">
        By joining Ziltag Partner, you agree to our <a href="http://blog.ziltag.com/post/136853735385/terms-of-service" target="_blank">term of use</a> and <a href="http://blog.ziltag.com/tagged/policy" target="_blank">privacy policy</a>.
      </div>
      <div className="ziltag-form-sign-up__error">{error}</div>
      <div className="ziltag-form-sign-up__button">
        <Button>Join</Button>
      </div>
    </form>
  )
}