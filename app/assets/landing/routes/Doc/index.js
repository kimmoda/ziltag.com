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
        <Link to="/" style={{textDecoration: 'none', color: 'black', fontSize: 14, fontWeight: 500}}>{t('home')}</Link>
        <ModalButton text={t('sign_up')} width={76} modalName="signUp" style={{fontSize: 14}}/>
        <ModalButton text={t('sign_in')} width={76} color="gray" modalName="signIn" style={{fontSize: 14}}/>
      </div>
      <div className="p-doc__body" dangerouslySetInnerHTML={{__html: t('doc_body')}}/>
      <Modal/>
      <style>{".ziltag-app{display:none;}"}</style>
    </div>
  )
})
