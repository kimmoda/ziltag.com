import './index.scss'
import React from 'react'

export default class Button extends React.Component {
  render () {
    const {backgroundColor, ...props} = this.props
    const style = {
      backgroundColor
    }
    return (
      <button className="ziltag-button" style={style} {...props} >
        {this.props.children}
      </button>
    )
  }
}
