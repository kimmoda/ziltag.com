import IconMenu from './IconMenu'
import * as actionTypes from '../../actions/types'
import './index.scss'

import React, { PropTypes } from 'react'
import { Link } from 'react-router'
import { connect } from 'react-redux'

class Header extends React.Component {
  static propTypes = {
    avatarURL: PropTypes.string,
  }

  render () {
    const {avatarURL, onClickSignOut} = this.props
    const inconMenuProps = {avatarURL, onClickSignOut}
    return(
      <div className="ziltag-header">
        <Link to="/">
          <div className="ziltag-header__logo">
          </div>
        </Link>
        <div className="ziltag-header__icon-menu">
          { avatarURL ? <IconMenu {...inconMenuProps} /> : null }
        </div>
      </div>
    )
  }
}

function mapStateToProps(state, ownProps){
  return state.me ? {avatarURL: state.me.avatar} : {}
}

function mapDispatchToProps(dispatch){
  return {
    onClickSignOut: () => dispatch({type: actionTypes.REQUEST_SIGN_OUT})
  }
}

Header = connect(mapStateToProps, mapDispatchToProps)(Header)

export default Header