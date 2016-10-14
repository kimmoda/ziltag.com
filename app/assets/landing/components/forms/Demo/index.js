import React from 'react'
import Button from 'ziltag-elements/dist/Button'

import './index.css'

function Demo(props) {
  const {fields: {url}, handleSubmit} = props
  return (
    <form className="l-demo-form" onSubmit={handleSubmit}>
      <input className="l-demo-form__field" name="url" placeholder="Paste your URL to see how Ziltag works…" type="url" {...url}/>
      <div className="l-demo-form__button"><Button text="Live Demo" width="100%"/></div>
    </form>
  )
}

Demo.defaultProps = {
  fields: {}
}

export default Demo
