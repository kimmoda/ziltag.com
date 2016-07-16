import * as actions from '../../../../actions'
import './index.scss'
import React, { PropTypes } from 'react'
import {connect} from 'react-redux'
import FlatButton from 'material-ui/FlatButton'
import Button from 'Button'

class AccountSetting extends React.Component {
  render () {
    const {isPartner, avatar, username, role, email, onClickSignOut, onClickPassword, onClickUpgrade, onChangeAvatar} = this.props
    return (
      <div className="ziltag-account-setting">
        <div className="ziltag-account-setting__avatar" style={{backgroundImage: `url('${avatar}')`}} onClick={_ => this.refs.file.click() }>
          <input ref="file" style={{display: 'none'}} name="file" type="file" onChange={event=>{event.target.files[0] && onChangeAvatar(event.target.files[0])}} />
        </div>
        <div className="ziltag-account-setting__info">
          <div className="ziltag-account-setting__username">{username}</div>
          <div className="ziltag-account-setting__role">{role}</div>
          <div className="ziltag-account-setting__fields">
            <div className="ziltag-account-setting__field">
              <div className="ziltag-account-setting__label">Email</div>
              <div className="ziltag-account-setting__value">{email}</div>
            </div>
            <div className="ziltag-account-setting__field">
              <div className="ziltag-account-setting__label">Password</div>
              <div className="ziltag-account-setting__value">
                ******** <a className="ziltag-account-setting__link" href="#" onClick={onClickPassword}>change</a>
              </div>
            </div>
          </div>
        </div>
        <div style={{marginRight: 38}}>
          {
            isPartner ? null : <Button style={{
                                  padding: 10, fontSize: 14,
                                  fontWeight: 500, width: 120
                                }} onClick={onClickUpgrade}>Install Plugin</Button>
          }
          <FlatButton style={{
            fontSize: 14,
            fontWeight: 500,
            color: 'rgba(0, 0, 0, .87)',
            display: 'block',
            width: 120,
            marginTop: 37
          }} onClick={onClickSignOut} label="SIGN OUT"/>
        </div>
      </div>
    )
  }
}

function mapStateToProps(state) {
  const me = state.entities.users[state.me]
  return {
    avatar: me.avatar,
    role: me.isPartner ? 'Ziltag Partner' : 'General User',
    username: me.name,
    email: me.email,
    isPartner: me.isPartner
  }
}

function mapDispatchToProps(dispatch) {
  return {
    onClickUpgrade: () => {
      dispatch(actions.openDialog('installPlugin'))
    },
    onClickSignOut: () => {
      dispatch(actions.signOut())
    },
    onClickPassword: (e) => {
      dispatch(actions.openDialog('password'))
    },
    onChangeAvatar: file => {
      dispatch(actions.uploadAvatar(file))
    }
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(AccountSetting)
