import './index.scss'
import React from 'react'
import classNames from 'classnames'
import { Link } from 'react-router'

export default class Menu extends React.Component {
  render () {
    return(
      <ul className="ziltag-menu">{this.props.children}</ul>
    )
  }
}

export class MenuItem extends React.Component {
  render () {
    const {to} = this.props
    return(
      <li className="ziltag-menu__item">
        <Link to={to} className="ziltag-menu__link" activeClassName="ziltag-menu__link--active">{this.props.children}</Link>
      </li>
    )
  }
}