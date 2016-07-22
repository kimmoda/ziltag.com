import React from 'react'
import Button from '../../../../Button'
import './index.scss'
import Tracker from 'Tracker'

const buttonStyle = {
  height: 66
}

export default props => (
  <div className="ziltag-landing-bottom">
    <div className="ziltag-landing-bottom__slogan">Engage your readers with the most intuitive way to explore photos.</div>
    <div className="ziltag-landing-bottom__buttons">
      <div className="ziltag-landing-bottom__button">
        <Tracker event="join_for_free_3">
          <Button style={buttonStyle} round onClick={props.onClickJoin}>Join for free</Button>
        </Tracker>
      </div>
      <div className="ziltag-landing-bottom__button">
        <Tracker event="go_to_help_center">
          <a href="https://ziltag.zendesk.com/" target="_blank"><Button style={{...buttonStyle, padding: 23}} round white>Go to help center</Button></a>
        </Tracker>
      </div>
    </div>
  </div>
)
