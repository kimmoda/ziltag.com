import React from 'react'
import './index.scss'
import Tracker from 'Tracker'

export default props => (
  <div className="ziltag-landing-footer">
    <ul className="ziltag-landing-footer__itmes">
      <li className="ziltag-landing-footer__item">
        <Tracker event="footer_about">
          <a target="_blank" href="http://blog.ziltag.com/tagged/about">ABOUT</a>
        </Tracker>
      </li>
      <li className="ziltag-landing-footer__item">
        <Tracker event="footer_blog">
          <a target="_blank" href="http://blog.ziltag.com/">BLOG</a>
        </Tracker>
      </li>
      <li className="ziltag-landing-footer__item">
        <Tracker event="footer_help">
          <a target="_blank" href="https://ziltag.zendesk.com/">HELP</a>
        </Tracker>
      </li>
      <li className="ziltag-landing-footer__item">
        <Tracker event="footer_terms">
          <a target="_blank" href="http://blog.ziltag.com/post/136853735385/terms-of-service">TERMS</a>
        </Tracker>
      </li>
      <li className="ziltag-landing-footer__item">
        <Tracker event="footer_privacy">
        </Tracker>
        <a target="_blank" href="http://blog.ziltag.com/tagged/policy">PRIVACY</a>
      </li>
    </ul>
    <div className="ziltag-landing-footer__copyright">© Ziltag Inc., 2016. All Rights Reserved.</div>
  </div>
)
