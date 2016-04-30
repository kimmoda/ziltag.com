import './index.scss'
import Tile from '../../ZiltagMapTile'
import PageBar from '../../PageBar'

import React, {PropTypes} from 'react'
import Masonry from 'react-masonry-component'
import {connect} from 'react-redux'

class RecommendedTags extends React.Component {
  static propTypes = {
    ziltagMaps: PropTypes.array
  }

  render () {
    const {ziltagMaps} = this.props
    const ziltagMapElements = ziltagMaps.map((ziltagMap) => {
      return (
        <div key={ziltagMap.id} className="ziltag-recommended-tags__tile">
          <Tile
            ziltags={ziltagMap.ziltags}
            imageURL={ziltagMap.src}
            avatarURL={ziltagMap.website.user.avatar}
            username={ziltagMap.website.user.name}
            siteDomain={ziltagMap.host}
            siteURL={ziltagMap.href}
          />
        </div>
      )
    })
    return(
      <div className="ziltag-recommended-tags">
        <PageBar>
          Recommended tags
        </PageBar>
        <Masonry
          className="ziltag-recommended-tags__body"
          options={{columnWidth: 340, gutter: 15}}>
          {ziltagMapElements}
        </Masonry>
      </div>
    )
  }
}

function mapStateToProps(state) {
  return {
    ziltagMaps: state.recommendedZiltagMaps
  }
}

export default connect(mapStateToProps)(RecommendedTags)