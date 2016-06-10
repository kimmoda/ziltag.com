import React from 'react'
import './index.scss'

export default props => (
  <div className="ziltag-cheer">
    <div className="ziltag-cheer__title">{props.title}</div>
    <div className="ziltag-cheer__subtitle">{props.subtitle}</div>
  </div>
)