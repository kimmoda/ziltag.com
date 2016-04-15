import './index.scss'

import React from 'react'
import { Link } from 'react-router'

export default class Header extends React.Component {
  render () {
    return(
      <div className="ziltag-header">
        <Link to="/dashboard"><div className="ziltag-header__logo"></div></Link>
      </div>
    )
  }
}