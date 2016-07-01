import './index.scss'
import React, { PropTypes } from 'react'

export class SettingSection extends React.Component {
  render () {
    const {children, title, right, noBorder} = this.props
    let className = 'ziltag-setting-section'
    if(noBorder) className += ' ziltag-setting-section--no-border'
    return (
      <div className={className}>
        <div className="ziltag-setting-section__bar">
          <div className="ziltag-setting-section__title">{title}</div>
          <div className="ziltag-setting-section__right">{right}</div>
        </div>
        <div>{children}</div>
      </div>
    )
  }
}

export function SectionBody(props){
  let className = 'ziltag-setting-section-body'
  if(props.dark) className += ' ziltag-setting-section-body--dark'
  return <div className={className}>{props.children}</div>
}

export default SettingSection