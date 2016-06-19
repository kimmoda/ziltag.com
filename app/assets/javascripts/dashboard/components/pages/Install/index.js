import React from 'react'
import { connect } from 'react-redux'
import Guide from '../../../containers/Guide'
import * as actions from '../../../actions'
import './index.scss'

function popupwindow(url, title, w, h) {
  var left = (screen.width/2)-(w/2);
  var top = (screen.height/2)-(h/2);
  return window.open(url, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+top+', left='+left);
}

export default props => (
  <div className="ziltag-install">
    <div className="ziltag-install__body">
      <div className="ziltag-install__bar">
        <div className="ziltag-install__text">
          <div className="ziltag-install__title">Your plugin is ready!</div>
          <div className="ziltag-install__subtitle">Please check your inbox for verification.</div>
        </div>
        <div className="ziltag-install__buttons">
          <div
            className="ziltag-install__button ziltag-install__button--twitter"
            onClick={_=>{
              popupwindow(`https://twitter.com/intent/tweet?text=${encodeURIComponent('I just become partner of @ZiltagApp! Get the simple and powerful #plugin for images now. https://ziltag.com')}`, 'twitter', 550, 211)
            }}
          />
          <div
            className="ziltag-install__button ziltag-install__button--facebook"
            onClick={_=>{
              popupwindow(`http://www.facebook.com/sharer/sharer.php?u=${encodeURIComponent('https://ziltag.com')}`, 'facebook', 550, 211)
            }}
          />
        </div>
      </div>
      <div className="ziltag-install__guide">
        <Guide />
      </div>
    </div>
  </div>
)