import IconMenu from './IconMenu'
import * as actions from '../../actions'
import './index.scss'

import React, { PropTypes } from 'react'
import { Link } from 'react-router'
import { connect } from 'react-redux'

class Header extends React.Component {
  static propTypes = {
    avatarURL: PropTypes.string,
  }

  render () {
    const {avatarURL, onClickSignOut, onClickSignIn} = this.props
    const inconMenuProps = {avatarURL, onClickSignOut}
    return(
      <div className="ziltag-header">
        <Link to={avatarURL ? '/dashboard' : '/'}>
          <div className="ziltag-header__logo">
          </div>
        </Link>
        <div className="ziltag-header__icon-menu">
          {avatarURL ? <IconMenu {...inconMenuProps} /> : <div onClick={onClickSignIn}>Sign In</div>}
        </div>
      </div>
    )
  }
}

function mapStateToProps(state, ownProps){
  const user = state.entities.users[state.me]
  return {
    avatarURL: user ? user.avatar : null
  }
}

function mapDispatchToProps(dispatch){
  return {
    onClickSignOut: () => dispatch(actions.signOut()),
    onClickSignIn: _ => dispatch(actions.openDialog('signIn'))
  }
}

Header = connect(mapStateToProps, mapDispatchToProps)(Header)

export default Header