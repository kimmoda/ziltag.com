import React, {PropTypes} from 'react'
import Close from 'react-icons/lib/md/close'
import Button from 'ziltag-elements/dist/Button'
import translate from 'hoc/translate'
import Spinner from 'ziltag-elements/dist/Spinner'
import {connect} from 'react-redux'
import {bindActionCreators} from 'redux'
import {openModal, showIframe, closeSnackBar} from '../../actions'
import Modal from 'Modal'
import {push} from 'react-router-redux'

import './index.css'

const Demo = props => {
  const {url, loading, snackbar, onClose, onSnackBarClose, onClickSignUp, tip, t, onIframeLoaded} = props
  const handleClickSnackBar = e => e.target.dataset.action == 'signUp' && onClickSignUp()
  return (
    <div className="l-demo">
      <iframe ref={iframeRef(onIframeLoaded)} style={{visibility: loading && 'hidden'}} className="l-demo__iframe" src={`https://preview.ziltag.com?url=${encodeURIComponent(url)}`}/>
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
        snackbar && (
          <div className="l-demo__snackbar" onClick={handleClickSnackBar}>
            <div dangerouslySetInnerHTML={{__html: t('demo_snackbar', {url: new URL(url).host})}}/>
            <Close className="l-demo__snackbar-close" onClick={onSnackBarClose} size={14}/>
          </div>
        )
      }
      { loading && <div className="l-demo__spinner"><Spinner/></div>}
      <Modal/>
    </div>
  )
}

Demo.propTypes = {
  url: PropTypes.string,
  onClose: PropTypes.func,
  onClickSignUp: PropTypes.func,
  tip: PropTypes.string
}

function iframeRef(handler){
  return function(iframe){
    iframe && iframe.addEventListener('load', function(e){
      handler()
    })
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(translate(Demo))

function mapStateToProps(state) {
  return state.demo
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({
    onClickSignUp: signUp,
    onClose: backToHome,
    onSnackBarClose: closeSnackBar,
    onIframeLoaded: showIframe
  }, dispatch)
}

function signUp() {
  return openModal('signUp')
}

function backToHome(){
  return push('/')
}
