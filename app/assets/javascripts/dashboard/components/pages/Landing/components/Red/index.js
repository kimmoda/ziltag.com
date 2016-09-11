import React from 'react'
import './index.scss'
import Tracker from 'Tracker'

export default props => (
  <div className="ziltag-landing-red">
    <div className="ziltag-landing-red__title">You should try it out if you wish to:</div>
    <div className="ziltag-landing-red__content">
      Discuss on various unique spots on an image.<br/>
      Enrich precise spots on an image with information.<br/>
      Embed different articles on an image.<br/>
      Sell things on images.<br/>
      Try new and cool tech products.
    </div>
    <Tracker event="join_now">
      <div className="ziltag-landing-red__button" onClick={props.onClickJoin}>Join now</div>
    </Tracker>
  </div>
)
