import React from 'react'
import Modal from 'Modal'
import ModalButton from 'ModalButton'
import translate from 'hoc/translate'
import {Link} from 'react-router'

import './index.css'

export default translate(props => {
  const {t} = props
  return (
    <div>
      <Link to="/"><div className="p-doc__logo"/></Link>
      <div className="p-doc__buttons">
        <Link to="/" style={{textDecoration: 'none', color: 'black', fontSize: 14, fontWeight: 500}}>Home</Link>
        <ModalButton text={t('sign_up')} width={76} modalName="signUp" style={{fontSize: 14}}/>
        <ModalButton text={t('sign_in')} width={76} color="gray" modalName="signIn" style={{fontSize: 14}}/>
      </div>
      <div className="p-doc__body">
        <h1>Plugin Configuration</h1>
        <h2>Attributes</h2>
        <h3>Disable</h3>
        <p>To disable Ziltag on specific image, add a <code>data-ziltag=&quot;false&quot;</code> attribute on the <code>img</code>.</p>
        <p><code>&lt;img src=&quot;...src&quot; data-ziltag=&quot;false&quot;/&gt;</code></p>
        <h3>Autoplay</h3>
        <p><code>&lt;img src=&quot;...src&quot; data-ziltag-autoplay=&quot;true|false&quot;/&gt;</code></p>
        <p>default: <code>true</code></p>
        <h3>Enable Switch</h3>
        <p><code>&lt;img src=&quot;...src&quot; data-ziltag-switch=&quot;true|false&quot;/&gt;</code></p>
        <p>default: <code>true</code></p>
        <h2>Limits</h2>
        <p>The <code>img</code>&#39;s width must be greater than or equal to <code>200px</code>, height must be greater than or equal to <code>100px</code>.</p>
      </div>
      <Modal/>
      <style>{".ziltag-app{display:none;}"}</style>
    </div>
  )
})
