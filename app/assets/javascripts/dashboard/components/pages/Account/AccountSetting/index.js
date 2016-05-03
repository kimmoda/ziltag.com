import './index.scss'
import React, { PropTypes } from 'react'
import {connect} from 'react-redux'

class AccountSetting extends React.Component {
  render () {
    const {avatar} = this.props
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
        <div className="ziltag-account-setting__sign-out">SIGN OUT</div>
      </div>
    )
  }
}

function mapStateToProps(state) {
  return state.me ? {
    avatar: state.me.avatar
  } : {}
}

export default connect(mapStateToProps)(AccountSetting)