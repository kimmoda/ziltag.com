import React from 'react'
import TextField from '../../TextField'
import './index.scss'

export const GeneralField = (props) => (
  <TextField color="black" placeholder="ex. http://example.com" {...props} />
)

export const DomainField = (ownProps) => {
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

export default props => {
  const {platform, url, tumblr, blogger} = props
  switch (platform.value) {
    case 'general':
      var field = <GeneralField required name="url" type="url" {...url} />
      break
    case 'tumblr':
      var field = <DomainField required name="tumblr" platform="tumblr" domain=".tumblr.com" {...tumblr} />
      break
    case 'blogger':
      var field = <DomainField required name="blogger" platform="blogger" domain=".blogspot.com" {...blogger} />
      break
  }
  return (
    <div className="ziltag-forms-domain-fields">
      <ul className="ziltag-forms-domain-fields__platforms">
        <li className="ziltag-forms-domain-fields__platform">
          <input className="ziltag-forms-domain-fields__radio" id="general" type="radio" {...platform} name="platform" value="general" checked={ platform.value === 'general' } />
          <label className="ziltag-forms-domain-fields__label" htmlFor="general">General</label>
        </li>
        <li className="ziltag-forms-domain-fields__platform">
          <input className="ziltag-forms-domain-fields__radio" id="tumblr" type="radio" {...platform} name="platform" value="tumblr" checked={ platform.value === 'tumblr' } />
          <label className="ziltag-forms-domain-fields__label" htmlFor="tumblr">Tumblr</label>
        </li>
        <li className="ziltag-forms-domain-fields__platform">
          <input className="ziltag-forms-domain-fields__radio" id="blogger" type="radio" {...platform} name="platform" value="blogger" checked={ platform.value === 'blogger' } />
          <label className="ziltag-forms-domain-fields__label" htmlFor="blogger">Blogger</label>
        </li>
      </ul>
      <div className="ziltag-forms-domain-fields__field">{field}</div>
    </div>
  )
}