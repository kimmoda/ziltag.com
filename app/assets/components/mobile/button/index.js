import React from 'react'
import './index.scss'
export default class MobileButton extends React.Component {
  render() {
    let className = 'ziltag-mobile-button'
    if(this.props.theme == 'dark') className += ' ziltag-mobile-button--dark'
    return(
      <button className={className} onClick={this.props.onClick}>{this.props.name}</button>
    )
  }
}