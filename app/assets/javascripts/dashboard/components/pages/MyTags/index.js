import PartnerNavBar from '../../PartnerNavBar'
import * as actions from '../../../actions'
import './index.scss'

import React from 'react'
import Masonry from 'react-masonry-component'
import { connect } from 'react-redux'
import Spinner from 'Spinner'

class MyTags extends React.Component {

  constructor(props) {
    super(props);
    this.state = {loaded: false}
  }

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
          {this.state.loaded || <div style={{width: 100, margin: '160px auto'}}><Spinner /></div>}
          <Masonry
            className="ziltag-my-tags__images-container"
            options={{columnWidth: 253}}
            style={{display: this.state.loaded ? 'inherit' : 'none'}}
            onImagesLoaded={_=>this.setState({loaded: true})}
            >
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
