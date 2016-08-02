import './index.scss'
import React from 'react'

export default class Footer extends React.Component {
  render () {
    return(
      <div className="ziltag-footer">
        <ul className="ziltag-footer__links">
          <li className="ziltag-footer__link"><a href="http://blog.ziltag.com/tagged/about" target="_blank">About</a></li>
          <li className="ziltag-footer__link"><a href="http://blog.ziltag.com/" target="_blank">Blog</a></li>
          <li className="ziltag-footer__link"><a href="http://blog.ziltag.com/2016/08/02/term-of-service/" target="_blank">Terms</a></li>
          <li className="ziltag-footer__link"><a href="http://blog.ziltag.com/2016/08/02/privacy-policy" target="_blank">Privacy</a></li>
        </ul>
        <div className="ziltag-footer__copyright">© Ziltag Inc., 2016. All Rights Reserved. </div>
      </div>
    )
  }
}
