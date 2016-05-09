import PartnerNavBar from '../../PartnerNavBar'
import * as actions from '../../../actions'
import './index.scss'

import React from 'react'
import Masonry from 'react-masonry-component'
import { connect } from 'react-redux'

class MyTags extends React.Component {
  render () {
    const { ziltagMaps, onClickZiltagMap } = this.props
    const imageElements = ziltagMaps.map((ziltagMap)=>{
      return(
        <div key={ziltagMap.id} className="ziltag-my-tags__image" onClick={()=>{onClickZiltagMap(ziltagMap.id)}}>
          <img width="100%" src={ziltagMap.src} style={{verticalAlign: 'middle'}}/>
        </div>
      )
    })
    return (
      <div className="ziltag-my-tags">
        <PartnerNavBar/>
        <div className="ziltag-my-tags__body">
          <div className="ziltag-my-tags__title-bar">My images to tag</div>
          <Masonry
            className="ziltag-my-tags__images-container"
            options={{columnWidth: 253}}>
            {imageElements}
          </Masonry>
        </div>
      </div>
    )
  }
}

function mapStateToProps(state) {
  const me = state.entities.users[state.me]
  const website = state.entities.websites[state.siteMenu.selected]
  const ziltagMaps = website.maps_without_tags.map(id => state.entities.ziltagMaps[id])
  return {
    ziltagMaps
  }
}

function mapDispatchToProps(dispatch) {
  return {
    onClickZiltagMap: (ziltagMapID) => dispatch(actions.openIframeModal(`/ziltag_maps/${ziltagMapID}`))
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(MyTags)