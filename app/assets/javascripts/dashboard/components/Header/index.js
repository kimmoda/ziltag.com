import './index.scss'

import React, { PropTypes } from 'react'
import { Link } from 'react-router'
import { connect } from 'react-redux'

class Header extends React.Component {
  static propTypes = {
    avatarURL: PropTypes.string,
    avatarTitle: PropTypes.string
  }

  render () {
    const {avatarURL, avatarTitle} = this.props
    return(
      <div className="ziltag-header">
        <Link to="/dashboard">
          <div className="ziltag-header__logo">
          </div>
        </Link>
        {
          avatarURL ?
          <div
            className="ziltag-header__avatar"
            title={avatarTitle}
            style={{backgroundImage: `url('${avatarURL}')`}}>
          </div>
          :
          null
        }

      </div>
    )
  }
}

function mapStateToProps(state, ownProps){
  return state.me ? {
    avatarTitle: state.me.name,
    avatarURL: state.me.avatar
  } : {}
}

Header = connect(mapStateToProps)(Header)

export default Header