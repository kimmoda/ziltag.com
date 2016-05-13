import './index.scss'
import React from 'react'

export default function (props) {
  return (
    <div className="ziltag-dialog-success">
      <div className="ziltag-dialog-success__icon"></div>
      <div className="ziltag-dialog-success__text">{props.message}</div>
    </div>
  )
}