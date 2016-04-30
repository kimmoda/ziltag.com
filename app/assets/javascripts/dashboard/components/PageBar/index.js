import './index.scss'
import React, { PropTypes } from 'react'

export default class PageBar extends React.Component {
  render () {
    return (
      <div className="ziltag-page-bar">
        {this.props.children}
      </div>
    )
  }
}