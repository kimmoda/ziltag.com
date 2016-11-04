import React from 'react'
import Modal from 'Modal'
import ModalButton from 'ModalButton'
import translate from 'hoc/translate'
import {Link} from 'react-router'
import Button from 'ziltag-elements/dist/Button'
import {connect} from 'react-redux'

import './index.css'

export default connect(
  state => ({
    isSignedIn: state.isSignedIn
  })
)(translate(props => {
  const {t, isSignedIn} = props
  return (
    <div>
      <Link to="/"><div className="p-doc__logo"/></Link>
      <div className="p-doc__buttons">
        <Link to="/" style={{textDecoration: 'none', color: 'black', fontSize: 14, fontWeight: 500}}>{t('home')}</Link>
        {isSignedIn || <ModalButton text={t('sign_up')} width={76} modalName="signUp" style={{fontSize: 14}}/>}
        {isSignedIn || <ModalButton text={t('sign_in')} width={76} color="gray" modalName="signIn" style={{fontSize: 14}}/>}
        {isSignedIn && <a href="/dashboard/account/"><Button style={{fontSize: 14}} text={t('dashboard')}/></a>}
      </div>
      <div className="p-doc__body" dangerouslySetInnerHTML={{__html: t('doc_body')}}/>
      <Modal/>
      <style>{".ziltag-app{display:none;}"}</style>
    </div>
  )
}))
