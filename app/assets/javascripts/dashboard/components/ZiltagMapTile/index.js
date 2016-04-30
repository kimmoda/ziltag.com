import * as actions from '../../actions'
import './index.scss'

import React, { PropTypes } from 'react'
import { connect } from 'react-redux'

class ZiltagMapTile extends React.Component {
  static propTypes = {
    ziltags: PropTypes.arrayOf(PropTypes.object).isRequired,
    avatarURL: PropTypes.string.isRequired,
    username: PropTypes.string.isRequired,
    siteDomain: PropTypes.string.isRequired,
    siteURL: PropTypes.string.isRequired,
    onClickZiltag: PropTypes.func
  }

  render () {
    const {ziltags, imageURL, avatarURL, username, siteDomain, onClickZiltag} = this.props

    const ziltagElements = ziltags.map((ziltag) => {
      let left = `${ziltag.x * 100}%`
      let top = `${ziltag.y * 100}%`
      return (
        <div
          key={ziltag.id}
          className="ziltag-ziltag-map-tile__tag"
          style={{left, top}}
          onClick={() => onClickZiltag(ziltag.id)}>
        </div>
      )
    })

    return (
      <div className="ziltag-ziltag-map-tile">
        <div className="ziltag-ziltag-map-tile__image-container">
          <img className="ziltag-ziltag-map-tile__image" width="100%" src={imageURL}/>
          {ziltagElements}
        </div>
        <div className="ziltag-ziltag-map-tile__footer">
          <div className="ziltag-ziltag-map-tile__avatar" style={{backgroundImage: `url('${avatarURL}')`}}></div>
          <div className="ziltag-ziltag-map-tile__text-container">
            <div className="ziltag-ziltag-map-tile__username">{username}</div>
            <div className="ziltag-ziltag-map-tile__domain">From: {siteDomain}</div>
          </div>
        </div>
      </div>
    )
  }
}

function mapDispatchToProps(dispatch) {
  return {
    onClickZiltag: (ziltagID) => dispatch(actions.openIframeModal(`/ziltags/${ziltagID}`))
  }
}

export default connect(null, mapDispatchToProps)(ZiltagMapTile)