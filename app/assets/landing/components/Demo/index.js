import React, {PropTypes} from 'react'
import Close from 'react-icons/lib/md/close'
import Button from 'ziltag-elements/dist/Button'
import translate from 'hoc/translate'
import Spinner from 'ziltag-elements/dist/Spinner'

import './index.css'

const Demo = props => {
  const {isOpen, url, loading, onClose, onClickSignUp, tip, t, onIframeLoaded} = props
  return isOpen && (
    <div className="l-demo">
      <iframe ref={iframeRef(onIframeLoaded)} style={{display: loading && 'none'}} className="l-demo__iframe" src={`https://preview.ziltag.com?url=${encodeURIComponent(url)}`}/>
      <div className="l-demo__header">
        <div className="l-demo__left-container">
          <div className="l-demo__logo"/>
          <div className="l-demo__title">{t('demo')}</div>
        </div>
        <div className="l-demo__right-container">
          <Button text={t('join_now')} onClick={onClickSignUp}/>
          <Close className="l-demo__close" size={40} onClick={onClose}/>
        </div>
      </div>
      {
        loading || (
          <div className="l-demo__tip">
            <div className="l-demo__tip-title">{t('tip')}</div>
            <div className="l-demo__tip-text">{t(tip)}</div>
          </div>
        )
      }
      {
        loading || <div className="l-demo__snackbar">This is a demo applied to <b>{url}</b> using Ziltag Plugin. The plugin might not work for this site due to technical issues. If you have any problem, please <a href="mailto:hi@ziltag.com"><b>contact us</b></a>. Wish to install it? Please <a href="javascript:void(0)" onClick={onClickSignUp}><b>sign up</b></a>.</div>
      }
      { loading && <div className="l-demo__spinner"><Spinner/></div>}
    </div>
  )
}

Demo.propTypes = {
  isOpen: PropTypes.bool,
  url: PropTypes.string,
  onClose: PropTypes.func,
  onClickSignUp: PropTypes.func,
  tip: PropTypes.string
}

Demo.defaultProps = {
  isOpen: true
}

function iframeRef(handler){
  return function(iframe){
    iframe && iframe.addEventListener('load', function(e){
      handler()
    })
  }
}

export default translate(Demo)
