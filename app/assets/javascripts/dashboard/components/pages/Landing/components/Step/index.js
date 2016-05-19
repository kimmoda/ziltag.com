import React from 'react'
import './index.scss'

export default props => (
  <div className="ziltag-landing-step">
    <div className={`ziltag-landing-step__icon ziltag-landing-step__icon--${props.icon}`}></div>
    <div className="ziltag-landing-step__bottom">
      <div className="ziltag-landing-step__number">{props.number}</div>
      <div className="ziltag-landing-step__right">
        <div className="ziltag-landing-step__name">{props.name}</div>
        <div className="ziltag-landing-step__summery">{props.summery}</div>
      </div>
    </div>
  </div>
)