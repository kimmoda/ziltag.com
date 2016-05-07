import './index.scss'
import React, { PropTypes } from 'react'

export default class DomainInfo extends React.Component {
  render () {
    const {domain, myTagsCount, readerTagsCount, commentsCount, token} = this.props
    const script = `<script src="https://ziltag.com/plugin.js" data-ziltag="${token}"></script>`
    return (
      <div className="ziltag-domain-info">
        <div className="ziltag-domain-info__data">
          <div className="ziltag-domain-info__home">{domain}</div>
          <div className="ziltag-domain-info__chart"></div>
          <div className="ziltag-domain-info__code">{script}</div>
        </div>
        <div className="ziltag-domain-info__actions">
          <div className="ziltag-domain-info__edit"></div>
          <div className="ziltag-domain-info__delete"></div>
        </div>
      </div>
    )
  }
}