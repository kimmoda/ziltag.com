import React from 'react'
import Modal from 'Modal'
import Header from 'Header'
import ModalButton from 'ModalButton'
import translate from 'hoc/translate'
import {Link} from 'react-router'
import Button from 'ziltag-elements/dist/Button'
import {connect} from 'react-redux'

import './index.css'

export default connect(
  state => ({
    isSignedIn: state.isSignedIn,
    isWide: state.window.width >= 2048
  })
)(translate(props => {
  const {t, isSignedIn, isWide} = props
  return (
    <div>
      <Header>
        <Link className="p-doc__button p-doc__button--home" to="/" style={{textDecoration: 'none', color: '#333333', fontSize: 14, fontWeight: 500}}>{t('home')}</Link>
      </Header>
      <div className="p-doc__body" dangerouslySetInnerHTML={{__html: t('doc_body')}}/>
      <Modal/>
    </div>
  )
}))
