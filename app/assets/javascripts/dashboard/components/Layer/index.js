import React from 'react'
import './index.scss'

export default props => (
  props.open ? (
    <div className="ziltag-layer" onClick={props.onClick}>
      <div onClick={e=>e.stopPropagation()}>{props.children}</div>
    </div>
  ) : null
)