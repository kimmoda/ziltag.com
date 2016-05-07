import './index.scss'
import React, { PropTypes } from 'react'

export class SettingSection extends React.Component {
  render () {
    const {children, title, right} = this.props
    return (
      <div className="ziltag-setting-section">
        <div className="ziltag-setting-section__bar">
          <div className="ziltag-setting-section__title">{title}</div>
          <div className="ziltag-setting-section__right">{right}</div>
        </div>
        {children}
      </div>
    )
  }
}

export class SectionBody extends React.Component {
  render () {
    return <div className="ziltag-setting-section-body">{this.props.children}</div>
  }
}

export default SettingSection