import React from 'react'
import Checked from 'components/modals/Checked'
import translate from 'hoc/translate'
import './index.css'

export default translate(props => (
  <div className="m-sent-demo-link">
    <Checked message={props.t('email_sent')}/>
  </div>
))
