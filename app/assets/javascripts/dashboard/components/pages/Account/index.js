import AccountSetting from './AccountSetting'
import './index.scss'
import React from 'react'
import {connect} from 'react-redux'

class Account extends React.Component {
  render () {
    const {loading} = this.props
    if(loading) return null
    return (
      <div className="ziltag-account">
        <AccountSetting />
      </div>
    )
  }
}

function mapStateToProps(state) {
  return {loading: !state.me}
}

export default connect(mapStateToProps)(Account)