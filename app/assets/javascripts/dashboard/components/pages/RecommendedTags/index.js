import './index.scss'
import PageBar from '../../PageBar'

import React from 'react'
import Masonry from 'masonry-layout'

export default class RecommendedTags extends React.Component {
  componentDidMount () {
    var msnry = new Masonry(this.refs.body, {
      columnWidth: 340,
      gutter: 15
    })
  }

  render () {
    return(
      <div className="ziltag-recommended-tags">
        <PageBar>Recommended tags</PageBar>
        <div className="ziltag-recommended-tags__body" ref="body">
          <div className="ziltag-recommended-tags__tile"></div>
          <div className="ziltag-recommended-tags__tile"></div>
          <div className="ziltag-recommended-tags__tile"></div>
          <div className="ziltag-recommended-tags__tile"></div>
          <div className="ziltag-recommended-tags__tile"></div>
        </div>
      </div>
    )
  }
}