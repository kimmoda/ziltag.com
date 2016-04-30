import './index.scss'
import React, { PropTypes } from 'react'

export default class ZiltagMapTile extends React.Component {
  static propTypes = {
    ziltags: PropTypes.arrayOf(PropTypes.object).isRequired,
    avatarURL: PropTypes.string.isRequired,
    username: PropTypes.string.isRequired,
    siteDomain: PropTypes.string.isRequired,
    siteURL: PropTypes.string.isRequired
  }

  static defaultProps = {
    ziltags: [],
    imageURL: 'https://fakeimg.pl/200x200/',
    avatarURL: 'https://fakeimg.pl/150/',
    username: 'tonytonyjan',
    siteDomain: 'tonytonyjan.net',
  }

  render () {
    const {ziltags, imageURL, avatarURL, username, siteDomain} = this.props

    const ziltagElements = ziltags.map((ziltag) => {
      let left = `${ziltag.x * 100}%`
      let top = `${ziltag.y * 100}%`
      return <div key={ziltag.id} className="ziltag-ziltag-map-tile__tag" style={{left, top}}></div>
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