import React from 'react'
import './index.scss'
import Tracker from 'Tracker'

export default props => (
  <div className="ziltag-landing-red">
    <div className="ziltag-landing-red__title">Ready to make your website awesome?</div>
    <div className="ziltag-landing-red__content">We’re so glad to have you here!<br/><br/>Ziltag is a visual tagging plugin that helps you discover and discuss wonderful things. By directly connecting users to everything on images, we make information more accessible and shareable, giving more creativities and freedom to website owners. Ziltag Plugin can be installed on all kinds of website and blogging platform. Join Ziltag Partner for free to install our super plugin to your website and enable the magic happen!</div>
    <Tracker event="join_now">
      <div className="ziltag-landing-red__button" onClick={props.onClickJoin}>Join now</div>
    </Tracker>
  </div>
)
