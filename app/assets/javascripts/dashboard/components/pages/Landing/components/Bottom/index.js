import React from 'react'
import Button from '../../../../Button'
import './index.scss'

const buttonStyle = {
  height: 66
}

export default props => (
  <div className="ziltag-landing-bottom">
    <div className="ziltag-landing-bottom__slogan">Engage your readers with the most intuitive way to explore photos.</div>
    <div className="ziltag-landing-bottom__buttons">
      <div className="ziltag-landing-bottom__button">
        <Button style={buttonStyle} round onClick={props.onClickJoin}>JOIN FORE FREE</Button>
      </div>
      <div className="ziltag-landing-bottom__button">
        <a href="http://help.ziltag.com" target="_blank"><Button style={{...buttonStyle, padding: 23}} round white>GO TO HELP CENTER</Button></a>
      </div>
    </div>
  </div>
)