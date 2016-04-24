import './index.scss'
import React from 'react'

export default class Field extends React.Component {
  render () {
    return (
      <input {...this.props} className="ziltag-field" />
    )
  }
}
