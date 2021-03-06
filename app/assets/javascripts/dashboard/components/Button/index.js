import './index.scss'
import React from 'react'
import classNames from 'classnames'

export default class Button extends React.Component {
  render () {
    const {gray, round, white, ...props} = this.props
    const className = classNames(
      'ziltag-button', {
        'ziltag-button--gray': gray,
        'ziltag-button--round': round,
        'ziltag-button--white': white
      }
    )
    return (
      <button className={className} {...props} >
        {this.props.children}
      </button>
    )
  }
}
