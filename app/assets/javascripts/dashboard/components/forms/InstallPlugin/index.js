import React from 'react'
import './index.scss'
import TextField from 'TextField'
import Button from 'Button'
export default props => {
  const {fields: {url}, handleSubmit, error} = props
  return (
    <form className="ziltag-forms-upgrade" onSubmit={handleSubmit}>
      <div className="ziltag-forms-upgrade__title">Install Ziltag Plugin</div>
      <div className="ziltag-forms-upgrade__subtitle">Please provide your website URL for plugin to work. </div>
      <TextField style={{marginTop: 50}} placeholder="WEBSITE URL (ex. //example.com)" {...url}/>
      <Button style={{marginTop: 46}}>Join</Button>
      <div className="ziltag-forms-upgrade__footer">By joining Ziltag Partner, you agree to our <a href="//blog.ziltag.com/2016/08/02/term-of-service/" target="_blank">term of use</a> and <a href="//blog.ziltag.com/2016/08/02/privacy-policy" target="_blank">privacy policy</a>.</div>
      {error ? <div className="ziltag-forms-upgrade__error">{error}</div> : null}
    </form>
  )
}
