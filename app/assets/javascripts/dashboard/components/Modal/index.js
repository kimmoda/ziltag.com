import './index.scss'
import React, {PropTypes} from 'react'

export default class Modal extends React.Component {
  static propTypes = {
    onClickOverlay: PropTypes.func,
    isActive: PropTypes.bool
  }

  static defaultProps = {
    isActive: false
  }

  render () {
    const {onClickOverlay, isActive} = this.props
    if(!isActive) return null
    return (
      <div className="ziltag-modal" onClick={onClickOverlay}>
        <div className="ziltag-modal__body">{this.props.children}</div>
      </div>
    )
  }
}
