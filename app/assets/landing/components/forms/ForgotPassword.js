import React from 'react'
import Form from 'ziltag-elements/dist/Form'
import TextField from 'ziltag-elements/dist/TextField'
import Button from 'ziltag-elements/dist/Button'
import translate from 'hoc/translate'

function ForgotPassword(props) {
  const {
    fields: {email}, handleSubmit, error, t
  } = props
  return (
    <Form
      onSubmit={handleSubmit}
      fields={[
        <TextField width="100%" placeholder={t('email')} {...email} type="email"/>,
      ]}
      button={<Button width="100%" text={t('send')}/>}
      tip={t('we_will_send_you_a_password_reset_instruction')}
      error={error}
      />
  )
}

ForgotPassword.defaultProps = {
  fields: {}
}

export default translate(ForgotPassword)
