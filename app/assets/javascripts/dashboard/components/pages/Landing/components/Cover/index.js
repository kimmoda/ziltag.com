import React from 'react'
import Button from '../../../../Button'
import Slider from '../../containers/Slider'
import './index.scss'
import Tracker from 'Tracker'

const buttonStyle = {
  height: 70
}

export default props => (
  <div className="ziltag-landing-cover">
    <div className="ziltag-landing-cover__left">
      <div className="ziltag-landing-cover__title">The Ultimate Plugin<br/>Built for Your Website</div>
      <div className="ziltag-landing-cover__subtitle">Connecting readers with every little details on images, we bring contents on your website alive. </div>
      <div className="ziltag-landing-cover__buttons">
        <div className="ziltag-landing-cover__button">
          <Tracker event="join_for_free"><Button style={buttonStyle} round onClick={props.onClickJoin}>Join for free</Button></Tracker>
        </div>
        <div className="ziltag-landing-cover__button">
          <Tracker event="watch_video">
            <Button style={buttonStyle} round gray onClick={props.onClickWatchVideo}>Watch Video</Button>
          </Tracker>
        </div>
      </div>
    </div>
    <div
      className="ziltag-landing-cover__screen"
      style={{
        left: props.screen.left,
        top: props.screen.top,
        width: props.screen.width,
        height: props.screen.height
      }}><Slider sliderHeight={props.screen.height}/></div>
    <div className="ziltag-landing-cover__footer">
      <ul className="ziltag-landing-cover__itmes">
        <li className="ziltag-landing-cover__item">
          <Tracker event="about"><a target="_blank" href="http://blog.ziltag.com/tagged/about">ABOUT</a></Tracker>
        </li>
        <li className="ziltag-landing-cover__item">
          <Tracker event="blog"><a target="_blank" href="http://blog.ziltag.com/">BLOG</a></Tracker>
        </li>
        <li className="ziltag-landing-cover__item">
          <Tracker event="help"><a target="_blank" href="https://ziltag.zendesk.com/">HELP</a></Tracker>
        </li>
        <li className="ziltag-landing-cover__item">
          <Tracker event="terms"><a target="_blank" href="http://blog.ziltag.com/post/136853735385/terms-of-service">TERMS</a></Tracker>
        </li>
        <li className="ziltag-landing-cover__item">
          <Tracker event="privacy"><a target="_blank" href="http://blog.ziltag.com/tagged/policy">PRIVACY</a></Tracker>
        </li>
      </ul>
      <div className="ziltag-landing-cover__copyright">© Ziltag Inc., 2016. All Rights Reserved. </div>
    </div>
  </div>
)
