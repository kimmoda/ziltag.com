import './index.scss'
import React, { PropTypes } from 'react'

export default class TextField extends React.Component {
  render () {
    return (
      <input className="ziltag-text-field" type="text" {...this.props} />
    )
  }
}