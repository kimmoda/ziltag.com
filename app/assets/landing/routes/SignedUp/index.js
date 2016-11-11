import React from 'react'
import translate from 'hoc/translate'
import './index.css'

export default translate(props => {
  const {t} = props
  return (
    <div style={{height: '100vh', backgroundColor: '#F9F9F9'}}>
      <div className="m-thanks">
        <div className="m-thanks__logo"/>
        <div className="m-thanks__title">{t('thanks_for_signing_up')}</div>
        <div className="m-thanks__subtitle">{t('a_verification_email_has_been_sent')}</div>
      </div>
      <div className="m-share">
        <div className="m-share__title">{t('spread_the_word')}</div>
        <div className="m-share__subtitle">{t('tell_your_friends')}</div>
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
})
