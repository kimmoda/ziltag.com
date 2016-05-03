import MyTags from '../MyTags'
import RecommendedTags from '../RecommendedTags'

import React, { PropTypes } from 'react'
import { connect } from 'react-redux'

class Home extends React.Component {
  static propTypes = {
    isPartner: PropTypes.bool
  }

  render () {
    const {isPartner} = this.props
    return isPartner ? <MyTags/> : <RecommendedTags/>
  }
}

function mapStateToProps(state) {
  return {isPartner: state.me ? state.me.isPartner : false}
}

export default connect(mapStateToProps)(Home)