import React from 'react'
import translate from '../../hoc/translate'
import Button from 'ziltag-elements/dist/Button'
import './index.css'
export default translate(props => {
  const {children, showSignUp, showSignIn, showDashboard, t, isWide, ModalButton} = props
  return (
    <div className="c-header">
      <div className="c-header__logo"/>
      <div className="c-header__auth-buttons">
        {children}
        {showSignUp && <div className="c-header__auth-button"><ModalButton text={t('sign_up')} width={isWide ? '20vw' : null} modalName="signUp" style={{fontSize: isWide ? '2vw' : 14}}/></div>}
        {showSignIn && <div className="c-header__auth-button c-header__auth-button--sign-in"><ModalButton text={t('sign_in')} width={isWide ? '10vw' : null} color="gray" modalName="signIn" style={{fontSize: isWide ? '2vw' : 14}}/></div>}
        {showDashboard && <a className="c-header__auth-button c-header__auth-button--dashboard" href="/dashboard/account/"><Button style={{fontSize: isWide ? '2vw' : 14}} text={t('dashboard')}/></a>}
      </div>
    </div>
  )
})
