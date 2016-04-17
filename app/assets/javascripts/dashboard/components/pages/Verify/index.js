import {CheerBoard} from '../../../components/MessageBoard'
import Field from '../../../components/Field'
import Button from '../../../components/Button'
import './index.scss'
import React from 'react'

export default class Verify extends React.Component {
  render () {
    return(
      <div className="ziltag-verify">
        <CheerBoard />
        <form className="ziltag-verify__form">
          <div className="ziltag-verify__fields">
            <div className="ziltag-verify__field">
              <Field placeholder="Password" name="password" />
            </div>
            <div className="ziltag-verify__field">
              <Field placeholder="Confirm password" name="password_confirmation"/>
            </div>
          </div>
          <input type="text" name="confirmation_token" />
          <div className="ziltag-verify__button">
            <Button>OK</Button>
          </div>
        </form>
      </div>
    )
  }
}