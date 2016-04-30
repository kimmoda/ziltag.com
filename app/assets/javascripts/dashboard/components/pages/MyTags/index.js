import PartnerNavBar from '../../PartnerNavBar'
import './index.scss'

import React from 'react'
import Masonry from 'react-masonry-component'

export default class MyTags extends React.Component {
  render () {
    return (
      <div className="ziltag-my-tags">
        <PartnerNavBar />
        <div className="ziltag-my-tags__body">
          <div className="ziltag-my-tags__title-bar">My images to tag</div>
          <Masonry
            className="ziltag-my-tags__images-container"
            options={{columnWidth: 253}}>
          </Masonry>
        </div>
      </div>
    )
  }
}