import MyTags from '../MyTags'
import Account from '../Account'

import React, { PropTypes } from 'react'
import { connect } from 'react-redux'

class Home extends React.Component {
  render () {
    const {show, isPartner} = this.props
    if(!show) return null
    return isPartner ? <MyTags/> : <Account/>
  }
}

function mapStateToProps(state) {
  const me = state.entities.users[state.me]
  if(!me) return {show: false, isPartner: false}
  return {show: true, isPartner: me.isPartner}
}

export default connect(mapStateToProps)(Home)
