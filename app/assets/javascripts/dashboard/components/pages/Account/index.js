import AccountSetting from './AccountSetting'
import DomainSetting from './DomainSetting'
import './index.scss'
import React from 'react'
import {connect} from 'react-redux'

class Account extends React.Component {
  render () {
    const {show, showDomainSetting} = this.props
    if(!show) return null
    return (
      <div className="ziltag-account">
        <div className="ziltag-account__section">
          <AccountSetting />
        </div>
        {
          showDomainSetting ?
            <div className="ziltag-account__section">
              <DomainSetting />
            </div>
          :
            null
        }

      </div>
    )
  }
}

function mapStateToProps(state) {
  return {
    show: !!state.me,
    showDomainSetting: state.me && state.entities.users[state.me].isPartner
  }
}

export default connect(mapStateToProps)(Account)