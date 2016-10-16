import Modal from 'Modal'
import ModalButton from 'ModalButton'
import Highlight from 'highlight.js'
import Demo from 'Demo'
import DemoForm from 'forms/Demo'

import React from 'react'
import Button from 'ziltag-elements/dist/Button'

require('highlight.js/styles/atom-one-light.css')
require('./index.css')

const example = `<img src="sample.jpg">

<script
  src="https://ziltag.com/plugin.js"
  data-ziltag="YOUR_TOKEN">
</script>`

export default () => (
  <div className="p-home">
    <div className="p-home__cover">
      <img className="p-home__cover-image" src={require('./cover.jpg')} data-ziltag-switch="false"/>
      <div className="p-home__auth-buttons">
        <ModalButton text="Sign Up" modalName="signUp" style={{fontSize: 14}}/>
        <ModalButton text="Sign In" color="gray" modalName="signIn" style={{fontSize: 14}}/>
      </div>
      <div className="p-home__intro">
        <div className="p-home__logo"/>
        <div style={{textAlign: 'center', marginTop: 48}}><div className="p-home__title">Discussion Board on Images</div></div>
        <div style={{textAlign: 'center', marginTop: 17}}><div className="p-home__subtitle">A simple one-line script for any website.</div></div>
        <DemoForm/>
      </div>
    </div>
    <div className="p-home__usage">
      <div className="p-home__usage-example">
        <div className="p-home__title" style={{textAlign: 'center'}}>Dead-Simple Installation</div>
        <pre className="p-home__code hljs html" dangerouslySetInnerHTML={{__html: Highlight.highlight('html', example).value}}/>
      </div>
      <div><img className="p-home__sample-image" src={require('./sample.jpg')}/></div>
    </div>
    <div className="p-home__get-start">
      <div style={{textAlign: 'center'}}><div className="p-home__title">Get Started Now</div></div>
      <div style={{marginTop: 26}}><ModalButton width={164} text="Sign Up" modalName="signUp"/></div>
      <div style={{marginTop: 16}}><ModalButton width={164} text="Watch Video" color="gray" modalName="video" modalMode="center"/></div>
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
    <Demo/>
    <Modal/>
  </div>
)
