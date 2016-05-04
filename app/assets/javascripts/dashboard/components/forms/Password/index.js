import './index.scss'
import React, {PropTypes} from 'react'
import TextField from '../../TextField'
import Button from '../../Button'

export default class Password extends React.Component {
  render () {
    const {fields: {oldPassword, newPassowrd, confirmPassword}, handleSubmit} = this.props
    return (
      <form className="ziltag-form-password" onSubmit={handleSubmit}>
        <div className="ziltag-form-password__fields">
          <div className="ziltag-form-password__field"><TextField type="password" placeholder="OLD PASSWORD" {...oldPassword} /></div>
          <div className="ziltag-form-password__field"><TextField type="password" placeholder="NEW PASSWORD" {...newPassowrd} /></div>
          <div className="ziltag-form-password__field"><TextField type="password" placeholder="CONFIRM PASSWORD" {...confirmPassword} /></div>
        </div>
        <div className="ziltag-form-password__button">
          <Button backgroundColor="#008BF3">OK</Button>
        </div>
      </form>
    )
  }
}