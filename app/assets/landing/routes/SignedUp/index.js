import React from 'react'
import './index.css'

export default () => (
  <div style={{height: '100vh'}}>
    <div className="m-thanks">
      <div className="m-thanks__logo"/>
      <div className="m-thanks__title">Thanks for signing up!</div>
      <div className="m-thanks__subtitle">A verification email has been sent. Please check your email to activate your account.</div>
    </div>
    <div className="m-share">
      <div className="m-share__title">Spread the word!</div>
      <div className="m-share__subtitle">Tell your friends about Ziltag!</div>
      <div style={{marginTop: 25}}>
        <a
          className="m-share-button m-share-button--twitter"
          href="https://twitter.com/intent/tweet?text=I%20just%20become%20partner%20of%20%40ZiltagApp!%20Get%20the%20simple%20and%20powerful%20%23plugin%20for%20images%20now.%20https%3A%2F%2Fziltag.com%2F"
          >SHARE</a>
      </div>
      <div style={{marginTop: 20}}>
        <a
          className="m-share-button m-share-button--fb"
          href="https://www.facebook.com/dialog/share?app_id=1601838906791253&display=popup&href=https%3A%2F%2Fziltag.com%2F&mobile_iframe=true&hashtag=%23ziltag"
        >
          SHARE
        </a>
      </div>
    </div>
  </div>
)
