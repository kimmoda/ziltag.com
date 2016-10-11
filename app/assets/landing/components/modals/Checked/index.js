import React from 'react'
import CheckCircle from 'react-icons/lib/md/check-circle'
import './index.css'

export default props => (
  <div className="l-checked">
    <CheckCircle className="l-checked__icon"/>
    <div className="l-checked__text">{props.message}</div>
  </div>
)
