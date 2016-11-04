import React from 'react'
import Form from 'ziltag-elements/dist/Form'
import TextField from 'ziltag-elements/dist/TextField'
import Button from 'ziltag-elements/dist/Button'
import translate from 'hoc/translate'

function SignIn(props) {
  const {
    fields: {username, password},
    handleSubmit, onForgotPassword, onSignUp, error, t,
    ...others
  } = props
  return (
    <Form
      title={t('sign_in')}
      onSubmit={handleSubmit}
      fields={[
        <TextField width="100%" placeholder={t('username_or_email')} {...username}/>,
        <TextField width="100%" placeholder={t(t('password'))} type="password" {...password}/>
      ]}
      button={<Button width="100%" text={t('sign_in')}/>}
      tip={<a href="javascript:void(0)" onClick={onForgotPassword}>{t('forgot_password')}</a>}
      footer={<div>{t('dont_have_an_account')} <a href="javascript:void(0)" onClick={onSignUp}>{t('sign_up')}</a></div>}
      error={error}
      />
  )
}

SignIn.defaultProps = {
  fields: {}
}

export default translate(SignIn)
