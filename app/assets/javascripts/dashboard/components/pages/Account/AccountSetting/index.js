import * as actions from '../../../../actions'
import './index.scss'
import React, { PropTypes } from 'react'
import {connect} from 'react-redux'
import FlatButton from 'material-ui/FlatButton'

class AccountSetting extends React.Component {
  render () {
    const {avatar, onClickSignOut} = this.props
    const buttonStyle = {
      marginRight: 17,
      fontSize: 14,
      fontWeight: 500,
      color: 'rgba(0, 0, 0, .87)',
    }
    return (
      <div className="ziltag-account-setting">
        <div className="ziltag-account-setting__avatar" style={{backgroundImage: `url('${avatar}')`}}></div>
        <div className="ziltag-account-setting__info">
          <div className="ziltag-account-setting__username">tonytonyjan</div>
          <div className="ziltag-account-setting__role">Ziltag Partner</div>
          <div className="ziltag-account-setting__fields">
            <div className="ziltag-account-setting__field">
              <div className="ziltag-account-setting__label">Email</div>
              <div className="ziltag-account-setting__value">tonytonyjan@gmail.com</div>
            </div>
            <div className="ziltag-account-setting__field">
              <div className="ziltag-account-setting__label">Password</div>
              <div className="ziltag-account-setting__value">
                ******** <a className="ziltag-account-setting__link" href="#">change</a>
              </div>
            </div>
          </div>
        </div>
        <FlatButton style={buttonStyle} onClick={onClickSignOut} label="SIGN OUT"/>
      </div>
    )
  }
}

function mapStateToProps(state) {
  return state.me ? {
    avatar: state.me.avatar
  } : {}
}

function mapDispatchToProps(dispatch) {
  return {
    onClickSignOut: () => {
      dispatch(actions.signOut())
    }
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(AccountSetting)