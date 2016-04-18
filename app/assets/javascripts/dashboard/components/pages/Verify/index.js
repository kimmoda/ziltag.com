import { CheerBoard } from '../../../components/MessageBoard'
import Field from '../../../components/Field'
import Button from '../../../components/Button'
import * as actionTypes from '../../../actions/types'
import * as actions from '../../../actions'
import './index.scss'
import React from 'react'
import { reduxForm } from 'redux-form';
import { connect } from 'react-redux'

class Verify extends React.Component {
  render () {
    const {fields: {password, password_confirmation, confirmation_token}, handleSubmit} = this.props
    return(
      <div className="ziltag-verify">
        <CheerBoard />
        <form className="ziltag-verify__form" onSubmit={handleSubmit} >
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
          <div className="ziltag-verify__error">{this.props._error}</div>
        </form>
      </div>
    )
  }
}

function mapStateToProps(state, ownProps) {
  return {
    initialValues: {
      password: '', password_confirmation: '',
      confirmation_token: ownProps.location.query.confirmation_token
    },
    _error: state.form.verify._error
  }
}

function mapDispatchToProps(dispatch) {
  return {
    onSubmit: (data) => {
      dispatch(actions.requestVerify(data))
    }
  }
}

Verify = reduxForm({
  form: 'verify',
  fields: ['password', 'password_confirmation', 'confirmation_token']
}, mapStateToProps, mapDispatchToProps)(Verify)

export default Verify