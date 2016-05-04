import './index.scss'
import React, { PropTypes } from 'react'

export default class Dialog extends React.Component {
  static propTypes = {
    open: PropTypes.bool.isRequired,
    onClose: PropTypes.func
  }
  static defaultProps = {
    open: true
  }
  render () {
    const {open, onClose} = this.props
    if(!open) return null
    return (
      <div className="ziltag-dialog" onClick={onClose}>
        <div className="ziltag-dialog__body" onClick={e=>e.stopPropagation()}>
          {this.props.children}
          <div className="ziltag-dialog__dismiss" onClick={onClose}></div>
        </div>
      </div>
    )
  }
}