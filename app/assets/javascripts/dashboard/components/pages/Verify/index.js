import { CheerBoard } from '../../../components/MessageBoard'
import Field from '../../../components/Field'
import Button from '../../../components/Button'
import './index.scss'
import React from 'react'
import { reduxForm } from 'redux-form';
import { connect } from 'react-redux'

class Verify extends React.Component {
  render () {
    const {fields: {password, password_confirmation, confirmation_token}, onSubmit} = this.props
    return(
      <div className="ziltag-verify">
        <CheerBoard />
        <form className="ziltag-verify__form" onSubmit={onSubmit} >
          <div className="ziltag-verify__fields">
            <div className="ziltag-verify__field">
              <Field placeholder="Password" {...password} />
            </div>
            <div className="ziltag-verify__field">
              <Field placeholder="Confirm password" {...password_confirmation} />
            </div>
          </div>
          <input type="hidden" {...confirmation_token} />
          <div className="ziltag-verify__button">
            <Button>OK</Button>
          </div>
        </form>
      </div>
    )
  }
}

const mapStateToProps = (state, ownProps) => {
  return {
    initialValues: {
      confirmation_token: ownProps.location.query.confirmation_token
    }
  }
}

Verify = reduxForm({
  form: 'verify',
  fields: ['password', 'password_confirmation', 'confirmation_token']
}, mapStateToProps)(Verify)

export default Verify