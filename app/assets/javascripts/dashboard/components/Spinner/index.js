import './index.scss'
import React from 'react'

export default function (props) {
  return (
    <div className="ziltag-spinner">
      <div className="ziltag-spinner__continaer">
        <div className="ziltag-spinner__logo"></div>
        <div className="ziltag-spinner__circle"></div>
      </div>
      <div className="ziltag-spinner__text">loading</div>
    </div>
  )
}