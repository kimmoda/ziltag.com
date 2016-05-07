import './index.scss'
import React, { PropTypes } from 'react'
import { Link } from 'react-router'

export default class WebsiteStats extends React.Component {
  render () {
    const {myTags, readersTags, comments} = this.props
    return (
      <div className="ziltag-website-stats">
        <div className="ziltag-website-stats__item">
          My tags: <Link className="ziltag-website-stats__link" to="/dashboard/tags">{myTags}</Link>
        </div>
        <div className="ziltag-website-stats__item">
          Reader’s tags: <Link className="ziltag-website-stats__link" to="/dashboard/tags">{readersTags}</Link>
        </div>
        <div className="ziltag-website-stats__item">
          Comments: <Link className="ziltag-website-stats__link" to="/dashboard/comments">{comments}</Link>
        </div>
      </div>
    )
  }
}