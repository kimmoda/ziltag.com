import './index.scss'
import React from 'react'

export default class Button extends React.Component {
  render () {
    const {backgroundColor, style, ...props} = this.props
    const buttonStyle = {
      ...style,
      backgroundColor
    }
    return (
      <button className="ziltag-button" style={buttonStyle} {...props} >
        {this.props.children}
      </button>
    )
  }
}
