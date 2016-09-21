import React from 'react'

if(typeof window !== 'undefined') require('./index.css')

export default () => (
  <div className="p-home">
    <div className="p-home__cover"></div>
    <div className="p-home__usage"></div>
    <div className="p-home__get-start"></div>
    <div className="p-home__footer">
      <div className="p-home__copyright">© Ziltag Inc., 2016. All Rights Reserved.</div>
      <ul className="p-home__links">
        <li className="p-home__link"><a href="http://blog.ziltag.com/about" target="_blank" ref="noopener">About</a></li>
        <li className="p-home__link"><a href="http://blog.ziltag.com" target="_blank" ref="noopener">Blog</a></li>
        <li className="p-home__link"><a href="http://blog.ziltag.com/terms" target="_blank" ref="noopener">Terms</a></li>
        <li className="p-home__link"><a href="http://blog.ziltag.com/privacy/" target="_blank" ref="noopener">Privacy</a></li>
      </ul>
    </div>
  </div>
)
