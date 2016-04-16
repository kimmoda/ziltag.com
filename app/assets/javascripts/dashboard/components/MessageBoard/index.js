import cheersImagePath from './cheers.png'
import mailImagePath from './mail.png'
import './index.scss'
import React, { PropTypes } from 'react'

export default class MessageBoard extends React.Component {
  render () {
    return (
      <div className="ziltag-message-board">
        <div className="ziltag-message-board__icon">{this.props.icon}</div>
        <div className="ziltag-message-board__text-container">
          <div className="ziltag-message-board__title">{this.props.title}</div>
          <div className="ziltag-message-board__subtitle">{this.props.subtitle}</div>
        </div>
      </div>
    )
  }
}

MessageBoard.PropTypes = {
  icon: PropTypes.element.isRequired,
  title: PropTypes.string.isRequired,
  subtitle: PropTypes.string.isRequired
}

export const CheerBoard = () => <MessageBoard
  icon={ <img src={cheersImagePath} width="66" /> }
  title="Thank you for verifying your account"
  subtitle="Please setup the password for your account." />

export const MailBoard = () => <MessageBoard
  icon={ <img src={mailImagePath} width="90" /> }
  title="Congratulation! Your plugin is ready."
  subtitle="We’ve sent you an email for verification. Please check your inbox." />