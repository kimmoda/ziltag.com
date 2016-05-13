import './index.scss'
import React, { PropTypes } from 'react'
import TextField from '../../TextField'
import Button from '../../Button'

export default class Domain extends React.Component {
  field () {
    const {fields: {platform, url, tumblr, blogger}} = this.props
    switch (platform.value) {
      case 'general':
        return <GeneralField required name="url" type="url" {...url} />
      case 'tumblr':
        return <DomainField required name="tumblr" platform="tumblr" domain=".tumblr.com" {...tumblr} />
      case 'blogger':
        return <DomainField required name="blogger" platform="blogger" domain=".blogspot.com" {...blogger} />
      default:
        return null
    }
  }

  render () {
    const {fields: {platform, url, tumblr, blogger}, handleSubmit, error, onChoosePlatform} = this.props
    return (
      <form className="ziltag-form-domain" onSubmit={handleSubmit}>
        <div className="ziltag-form-domain__title">Add New Domain</div>
        <ul className="ziltag-form-domain__platforms">
          <li className="ziltag-form-domain__platform">
            <input className="ziltag-form-domain__radio" id="general" type="radio" {...platform} name="platform" value="general" checked={ platform.value === 'general' } />
            <label className="ziltag-form-domain__label" htmlFor="general">General</label>
          </li>
          <li className="ziltag-form-domain__platform">
            <input className="ziltag-form-domain__radio" id="tumblr" type="radio" {...platform} name="platform" value="tumblr" checked={ platform.value === 'tumblr' } />
            <label className="ziltag-form-domain__label" htmlFor="tumblr">Tumblr</label>
          </li>
          <li className="ziltag-form-domain__platform">
            <input className="ziltag-form-domain__radio" id="blogger" type="radio" {...platform} name="platform" value="blogger" checked={ platform.value === 'blogger' } />
            <label className="ziltag-form-domain__label" htmlFor="blogger">Blogger</label>
          </li>
        </ul>
        <div className="ziltag-form-domain__field">{this.field()}</div>
        <div className="ziltag-form-domain__submit">
          <Button backgroundColor="#008BF3">ADD</Button>
        </div>
      </form>
    )
  }
}

const GeneralField = (props) => (
  <TextField color="black" placeholder="ex. http://example.com" {...props} />
)

const DomainField = (ownProps) => {
  const {platform, domain, ...props} = ownProps
  const fieldStyle = {
    paddingRight: 230
  }
  return (
    <div className="ziltag-domain-field">
      <TextField color="black" placeholder={`Your ${platform} ID`} style={fieldStyle} {...props} />
      <div className="ziltag-domain-field__domain">{domain}</div>
    </div>
  )
}