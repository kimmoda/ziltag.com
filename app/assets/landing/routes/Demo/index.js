import React, {PropTypes} from 'react'
import Close from 'react-icons/lib/md/close'
import Button from 'ziltag-elements/dist/Button'
import translate from 'hoc/translate'
import Spinner from 'ziltag-elements/dist/Spinner'
import {connect} from 'react-redux'
import {bindActionCreators} from 'redux'
import {openModal, showIframe, closeSnackBar, closeSignOutAlert} from '../../actions'
import Modal from 'Modal'
import {push} from 'react-router-redux'

import './index.css'

const mapStepsToKey = [
  {null}, // dummy element, steps begin with 1 instead of 0
  {headKey: 'welcome_please_follow_our_tutorial', stepKey: 'hover_on_an_image'},
  {headKey: null, stepKey: 'click_the_z_button'},
  {headKey: null, stepKey: 'find_anything'},
  {headKey: null, stepKey: 'write_anything'},
  {headKey: 'congratulation_you_have_learned', stepKey: null},
]

const Demo = props => {
  const {tip, url, loading, snackbar, onClose, onSnackBarClose, onClickSignUp, step, t, onIframeLoaded, signOutAlert, handleCloseSignOutAlert} = props
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
        tip && (loading || (
          <div className="l-demo__tip">
            {mapStepsToKey[step].headKey && <div className="l-demo__tip-head">{t(mapStepsToKey[step].headKey)}</div>}
            {mapStepsToKey[step].stepKey && (
              <div className="l-demo__tip-container" style={{marginTop: (mapStepsToKey[step].headKey && 18)}}>
                <div className="l-demo__tip-step">{t('step')} {step}.</div>
                <div className="l-demo__tip-text">{t(mapStepsToKey[step].stepKey)}</div>
              </div>
            )}
          </div>
        ))
      }
      {
        signOutAlert && (
          <div className="l-demo__alert">
            <div className="l-demo__alert-body">{t('sign_out_function')}</div>
            <div className="l-demo__alert-action">
              <div><Button text="OK" onClick={handleCloseSignOutAlert}/></div>
            </div>
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
  step: PropTypes.number
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
    onIframeLoaded: showIframe,
    handleCloseSignOutAlert: closeSignOutAlert
  }, dispatch)
}

function signUp() {
  return openModal('signUp')
}

function backToHome(){
  return push('/')
}
