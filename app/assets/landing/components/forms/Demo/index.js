import React from 'react'
import Button from 'ziltag-elements/dist/Button'
import translate from 'hoc/translate'

import './index.css'

function Demo(props) {
  const {fields: {url}, handleSubmit, t} = props
  return (
    <form className="l-demo-form" onSubmit={handleSubmit}>
      <input className="l-demo-form__field" name="url" placeholder={t('paste_your_url')} type="url" {...url}/>
      <div className="l-demo-form__button"><Button text={t('live_demo')} width="100%"/></div>
    </form>
  )
}

Demo.defaultProps = {
  fields: {}
}

export default translate(Demo)
