import * as actions from '../../actions'
import './index.scss'

import React, { PropTypes } from 'react'

export default class ZiltagMapTile extends React.Component {
  static propTypes = {
    ziltags: PropTypes.arrayOf(PropTypes.object).isRequired,
    avatarURL: PropTypes.string,
    username: PropTypes.string,
    siteDomain: PropTypes.string,
    siteURL: PropTypes.string,
    onClickZiltag: PropTypes.func,
    animation: PropTypes.bool
  }

  static defaultProps = {
    footer: true,
    animation: false
  }

  render () {
    const {animation, ziltags, imageURL, avatarURL, username, siteDomain, onClickZiltag, footer} = this.props
    const ziltagElements = ziltags.map((ziltag) => {
      let left = `${ziltag.x * 100}%`
      let top = `${ziltag.y * 100}%`
      return (
        <div
          key={ziltag.id}
          className="ziltag-ziltag-map-tile__tag"
          style={{left, top}}
          onClick={() => onClickZiltag(ziltag.id)}>
          {animation ? <div className="ziltag-ziltag-map-tile__animation"/> : null}
        </div>
      )
    })

    return (
      <div className="ziltag-ziltag-map-tile">
        <div className="ziltag-ziltag-map-tile__image-container">
          <img className="ziltag-ziltag-map-tile__image" src={imageURL} data-ziltag="false"/>
          {ziltagElements}
        </div>
        {
          footer ?
          <div className="ziltag-ziltag-map-tile__footer">
            <div className="ziltag-ziltag-map-tile__avatar" style={{backgroundImage: `url('${avatarURL}')`}}></div>
            <div className="ziltag-ziltag-map-tile__text-container">
              <div className="ziltag-ziltag-map-tile__username">{username}</div>
              <div className="ziltag-ziltag-map-tile__domain">From: {siteDomain}</div>
            </div>
          </div>
          : null
        }
      </div>
    )
  }
}