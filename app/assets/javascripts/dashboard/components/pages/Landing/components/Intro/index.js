import React from 'react'
import './index.scss'

export default class MobileIntro extends React.Component {
  render() {
    let iconClass = `ziltag-mobile-intro__icon ziltag-mobile-intro__icon--${this.props.icon}`
    return(
      <div className="ziltag-mobile-intro">
        <div className="ziltag-mobile-intro__wrapper">
          <div className={iconClass} />
          <div className="ziltag-mobile-intro__title">{this.props.title}</div>
          <div className="ziltag-mobile-intro__content">{this.props.content}</div>
        </div>
      </div>
    )
  }
}