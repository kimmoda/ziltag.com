import MyTags from '../MyTags'
import RecommendedTags from '../RecommendedTags'

import React, { PropTypes } from 'react'
import { connect } from 'react-redux'

class Home extends React.Component {
  static propTypes = {
    isUserVerified: PropTypes.bool
  }

  render () {
    const {isUserVerified} = this.props
    if(isUserVerified == null) return null
    return isUserVerified ? <MyTags/> : <RecommendedTags/>
  }
}

function mapStateToProps(state) {
  return {isUserVerified: state.me ? state.me.confirmed : null}
}

export default connect(mapStateToProps)(Home)