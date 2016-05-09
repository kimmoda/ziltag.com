import AccountSetting from './AccountSetting'
import DomainSetting from './DomainSetting'
import './index.scss'
import React from 'react'
import {connect} from 'react-redux'

class Account extends React.Component {
  render () {
    const {show} = this.props
    if(!show) return null
    return (
      <div className="ziltag-account">
        <div className="ziltag-account__section">
          <AccountSetting />
        </div>
        <div className="ziltag-account__section">
          <DomainSetting />
        </div>
      </div>
    )
  }
}

function mapStateToProps(state) {
  return {show: !!state.me}
}

export default connect(mapStateToProps)(Account)