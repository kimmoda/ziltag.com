import './index.scss'
import React, {PropTypes} from 'react'
import TextField from '../../TextField'
import Button from '../../Button'

export default class Password extends React.Component {
  render () {
    const {fields: {oldPassword, newPassword, confirmPassword}, handleSubmit} = this.props
    return (
      <form className="ziltag-form-password" onSubmit={handleSubmit}>
        <div className="ziltag-form-password__fields">
          <div className="ziltag-form-password__field"><TextField type="password" required placeholder="OLD PASSWORD" {...oldPassword} /></div>
          <div className="ziltag-form-password__field"><TextField type="password" required placeholder="NEW PASSWORD" {...newPassword} /></div>
          <div className="ziltag-form-password__field"><TextField type="password" required placeholder="CONFIRM PASSWORD" {...confirmPassword} /></div>
        </div>
        <div className="ziltag-form-password__button">
          <Button backgroundColor="#008BF3">OK</Button>
        </div>
      </form>
    )
  }
}