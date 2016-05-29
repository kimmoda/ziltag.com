import React from 'react'
import Step from '../Step'
import './index.scss'

export default props => (
  <div className="ziltag-landing-install">
    <div className="ziltag-landing-install__title">A Piece of Cake</div>
    <div className="ziltag-landing-install__subtitle">Install Ziltag Plugin to your website is incredibly easy.</div>
    <div className="ziltag-landing-install__steps">
      <div className="ziltag-landing-install__step">
        <Step icon="man" number="1" name="JOIN" summery="Join partner for free."/>
      </div>
      <div className="ziltag-landing-install__step">
        <Step icon="card" number="2" name="COPY" summery="Copy the script."/>
      </div>
      <div className="ziltag-landing-install__step">
        <Step icon="code" number="3" name="PASTE" summery="Paste it in HTML."/>
      </div>
    </div>
    <div className="ziltag-landing-install__button" onClick={props.onClickWatchVideo}>▶ WATCH INSTALLATION GUIDE</div>
  </div>
)