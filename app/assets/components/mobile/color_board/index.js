import React from 'react'
import './index.scss'

export default class MobileColorBoard extends React.Component {
  render() {
    let imageStyle = { backgroundImage: `url(${this.props.image})` }
    let colorStyle = { backgroundColor: this.props.color }
    return (
      <div className="ziltag-mobile-color-board" style={imageStyle}>
        <div className="ziltag-mobile-color-board__color-bg" style={colorStyle}>{this.props.children}</div>
      </div>
    )
  }
}