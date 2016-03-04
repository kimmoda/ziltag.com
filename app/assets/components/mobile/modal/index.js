import React from 'react'
import './index.scss'

export default class MobileModal extends React.Component {
  render() {
    return (
      <div className="ziltag-mobile-modal">
        { this.header() }
        <div className="ziltag-mobile-modal__block">{this.props.children}</div>
      </div>
    )
  }

  header() {
    if(this.props.dismissible){
      let headerClass = 'ziltag-mobile-modal__header'
      if(this.props.logo) headerClass += ' ziltag-mobile-modal__header--logo'
      return(
        <div className={headerClass} >
          <div className="ziltag-mobile-modal__header-dismiss" onClick={this.props.onDismiss} />
          <div className="ziltag-mobile-modal__header-text">{this.props.headerTitle}</div>
        </div>
      )
    } else return null
  }
}
