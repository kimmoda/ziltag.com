import * as actionTypes from '../../actions/types'
import './index.scss'

import React, { PropTypes } from 'react'
import { Link } from 'react-router'
import { connect } from 'react-redux'
import IconMenu from 'material-ui/IconMenu'
import MenuItem from 'material-ui/MenuItem'
import IconButton from 'material-ui/IconButton/IconButton'

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
        <div className="ziltag-header__icon-menu">
          <IconMenu
            iconButtonElement={
              <IconButton
                iconClassName="ziltag-header__avatar"
                style={{width: 40, height: 40, padding: 30}}
                iconStyle={{backgroundImage: `url("${avatarURL}")`}}/>
              // TODO https://github.com/callemall/material-ui/issues/2913
            }
            anchorOrigin={{horizontal: 'right', vertical: 'bottom'}}
            targetOrigin={{horizontal: 'right', vertical: 'top'}}
            >
            <Link className="ziltag-header__link" to="/dashboard"><MenuItem primaryText="Dashboard" /></Link>
            <MenuItem primaryText="Sign out" onClick={this.props.onClickSignOut} />
          </IconMenu>
        </div>
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

function mapDispatchToProps(dispatch){
  return {
    onClickSignOut: () => dispatch({type: actionTypes.REQUEST_SIGN_OUT})
  }
}

Header = connect(mapStateToProps, mapDispatchToProps)(Header)

export default Header