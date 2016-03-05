import React from 'react'
import './index.scss'

export default class MobileField extends React.Component{
  render() {
    let defaultProps = {type: 'text'}
    let props = Object.assign(defaultProps, this.props)
    return(
      <input {...props} className="ziltag-mobile-field" />
    )
  }
}