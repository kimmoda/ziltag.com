import './index.scss'
import Tile from '../../../containers/ZiltagMapTile'
import PageBar from '../../PageBar'

import React, {PropTypes} from 'react'
import Masonry from 'react-masonry-component'
import {connect} from 'react-redux'
import Spinner from 'Spinner'

class Explore extends React.Component {
  static propTypes = {
    ziltagMaps: PropTypes.array
  }
  constructor(props) {
    super(props);
    this.state = {loaded: false}
  }
  render () {
    const {ziltagMaps} = this.props
    const ziltagMapElements = ziltagMaps.map((ziltagMap) => {
      return (
        <div key={ziltagMap.id} className="ziltag-explore__tile">
          <Tile
            ziltags={ziltagMap.ziltags}
            imageURL={ziltagMap.src}
            avatarURL={ziltagMap.avatar}
            username={ziltagMap.username}
            siteDomain={ziltagMap.host}
            siteURL={ziltagMap.href}
          />
        </div>
      )
    })
    return(
      <div className="ziltag-explore">
        <PageBar>
          Recommended tags
        </PageBar>
        {this.state.loaded || <div style={{width: 100, margin: '160px auto'}}><Spinner /></div>}
        <Masonry
          className="ziltag-explore__body"
          style={{display: this.state.loaded ? 'inherit' : 'none'}}
          onImagesLoaded={this.state.loaded ? null : _=>this.setState({loaded: true})}
          options={{columnWidth: 340, gutter: 15}}>
          {ziltagMapElements}
        </Masonry>
      </div>
    )
  }
}

function mapStateToProps(state) {
  const ziltagMaps = state.recommendedZiltagMaps.map(id=>{
    let ziltagMap = state.entities.ziltagMaps[id]
    let website = state.entities.websites[ziltagMap.website]
    let user = state.entities.users[website.user]
    let avatar = user.avatar
    let username = user.name
    let ziltags = ziltagMap.ziltags.map(id => state.entities.ziltags[id])
    return {...ziltagMap, avatar, username, ziltags}
  })
  return {ziltagMaps}
}

export default connect(mapStateToProps)(Explore)
