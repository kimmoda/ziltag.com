import Modal from 'Modal'
import ModalButton from 'ModalButton'

import React from 'react'
import Button from 'ziltag-elements/dist/Button'

require('./index.css')

export default () => (
  <div className="p-home">
    <div className="p-home__cover">
      <img className="p-home__cover-image" src={require('./cover.jpg')}/>
      <div className="p-home__auth-buttons">
        <ModalButton text="Sign Up" modal="signUp" style={{fontSize: 14}}/>
        <ModalButton text="Sign In" color="gray" modal="signIn" style={{fontSize: 14}}/>
      </div>
      <div className="p-home__intro">
        <div className="p-home__logo"/>
        <div style={{textAlign: 'center', marginTop: 48}}><div className="p-home__title">Discuss & Discover Over Images</div></div>
        <div style={{textAlign: 'center', marginTop: 17}}><div className="p-home__subtitle">A simple one-line script to annotate on images.</div></div>
        <form className="p-home__demo-form">
          <input className="p-home__demo-field" placeholder="Paste your URL to see how Ziltag works…"/>
          <div className="p-home__demo-button"><Button text="Live Demo" width="100%"/></div>
        </form>
      </div>
    </div>
    <div className="p-home__usage">
      <div className="p-home__usage-example">
        <div className="p-home__title" style={{textAlign: 'center'}}>Dead-Simple Installation!</div>
        <pre className="p-home__code"><span style={{color: '#a65700'}}>&lt;</span><span style={{color: '#800000', fontWeight: 'bold'}}>img</span><span style={{color: '#274796'}}> </span><span style={{color: '#074726'}}>src</span><span style={{color: '#808030'}}>=</span><span style={{color: '#0000e6'}}>"sample.jpg"</span><span style={{color: '#a65700'}}>&gt;</span>{"\n"}{"\n"}<span style={{color: '#a65700'}}>&lt;</span><span style={{color: '#800000', fontWeight: 'bold'}}>script</span><span style={{color: '#5f5035'}} />{"\n"}<span style={{color: '#274796'}}>&nbsp;&nbsp;</span><span style={{color: '#074726'}}>src</span><span style={{color: '#808030'}}>=</span><span style={{color: '#0000e6'}}>"https://ziltag.com/plugin.js"</span><span style={{color: '#274796'}} />{"\n"}<span style={{color: '#274796'}}>&nbsp;&nbsp;</span><span style={{color: '#074726'}}>data</span><span style={{color: '#274796'}}>-ziltag</span><span style={{color: '#808030'}}>=</span><span style={{color: '#0000e6'}}>"xxxxxx"</span><span style={{color: '#a65700'}}>&gt;</span>{"\n"}<span style={{color: '#a65700'}}>&lt;/</span><span style={{color: '#800000', fontWeight: 'bold'}}>script</span><span style={{color: '#a65700'}}>&gt;</span>{"\n"}</pre>
      </div>
      <div><img className="p-home__sample-image" src={require('./sample.jpg')}/></div>
    </div>
    <div className="p-home__get-start">
      <div style={{textAlign: 'center'}}><div className="p-home__title">Get Started Now.</div></div>
      <div style={{marginTop: 26}}><ModalButton width={164} text="Sign Up" modal="signUp"/></div>
      <div style={{marginTop: 16}}><ModalButton width={164} text="Watch Video" color="gray" modal="video"/></div>
    </div>
    <div className="p-home__footer">
      <div className="p-home__copyright">© Ziltag Inc., 2016. All Rights Reserved.</div>
      <ul className="p-home__links">
        <li className="p-home__link"><a href="http://blog.ziltag.com/about" target="_blank" rel="noopener">About</a></li>
        <li className="p-home__link"><a href="http://blog.ziltag.com" target="_blank" rel="noopener">Blog</a></li>
        <li className="p-home__link"><a href="http://blog.ziltag.com/terms" target="_blank" rel="noopener">Terms</a></li>
        <li className="p-home__link"><a href="http://blog.ziltag.com/privacy/" target="_blank" rel="noopener">Privacy</a></li>
      </ul>
    </div>
    <Modal/>
  </div>
)
