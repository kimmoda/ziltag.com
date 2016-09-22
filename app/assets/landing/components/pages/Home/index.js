import React from 'react'
import Button from 'ziltag-elements/dist/Button'

require('./index.css')

export default () => (
  <div className="p-home">
    <div className="p-home__cover">
      <img className="p-home__cover-image" src={require('./cover.jpg')}/>
    </div>
    <div className="p-home__usage">
      <div className="p-home__usage-example">
        <div className="p-home__title" style={{textAlign: 'center'}}>Dead-Simple Installation!</div>
        <pre className="p-home__code"><span style={{color: '#a65700'}}>&lt;</span><span style={{color: '#800000', fontWeight: 'bold'}}>img</span><span style={{color: '#274796'}}> </span><span style={{color: '#074726'}}>src</span><span style={{color: '#808030'}}>=</span><span style={{color: '#0000e6'}}>"sample.jpg"</span><span style={{color: '#a65700'}}>&gt;</span>{"\n"}{"\n"}<span style={{color: '#a65700'}}>&lt;</span><span style={{color: '#800000', fontWeight: 'bold'}}>script</span><span style={{color: '#5f5035'}} />{"\n"}<span style={{color: '#274796'}}>&nbsp;&nbsp;</span><span style={{color: '#074726'}}>src</span><span style={{color: '#808030'}}>=</span><span style={{color: '#0000e6'}}>"https://ziltag.com/plugin.js"</span><span style={{color: '#274796'}} />{"\n"}<span style={{color: '#274796'}}>&nbsp;&nbsp;</span><span style={{color: '#074726'}}>data</span><span style={{color: '#274796'}}>-ziltag</span><span style={{color: '#808030'}}>=</span><span style={{color: '#0000e6'}}>"xxxxxx"</span><span style={{color: '#a65700'}}>&gt;</span>{"\n"}<span style={{color: '#a65700'}}>&lt;/</span><span style={{color: '#800000', fontWeight: 'bold'}}>script</span><span style={{color: '#a65700'}}>&gt;</span>{"\n"}</pre>
      </div>
      <img className="p-home__sample-image" src={require('./sample.jpg')}/>
    </div>
    <div className="p-home__get-start">
      <div className="p-home__title">Get Started Now.</div>
      <div style={{marginTop: 26}}><Button width={164} text="Sign Up"/></div>
      <div style={{marginTop: 16}}><Button width={164} text="Watch Video" color="gray"/></div>
    </div>
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
