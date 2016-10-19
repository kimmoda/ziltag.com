import React, {PropTypes} from 'react'
import TextField from 'ziltag-elements/dist/TextField'
import Button from 'ziltag-elements/dist/Button'
import Form from 'ziltag-elements/dist/Form'
import translate from 'hoc/translate'

function SignUp(props) {
  const {
    fields: {username, email, url},
    handleSubmit, onSignIn, error, t,
    ...others
  } = props
  return (
    <Form
      onSubmit={handleSubmit}
      fields={[
        <TextField width="100%" placeholder={t('username')} {...username}/>,
        <TextField width="100%" placeholder={t('email')} type="email" {...email}/>,
        <TextField width="100%" placeholder={t('url')} {...url}/>
      ]}
      button={<Button width="100%" text={t('sign_up')}/>}
      tip={<div dangerouslySetInnerHTML={{__html: t('agree_terms_and_privacy')}}/>}
      footer={<div>{t('already_have_an_account')} <a href="javascript:void(0)" onClick={onSignIn}>{t('sign_in')}</a></div>}
      error={error}
      />
  )
}

SignUp.defaultProps = {
  fields: {}
}

export default translate(SignUp)
