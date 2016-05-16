import WebsiteStats from '../WebsiteStats'
import './index.scss'
import React, { PropTypes } from 'react'
import {connect} from 'react-redux'
import {openDialog} from '../../actions'

class DomainInfo extends React.Component {
  render () {
    const {id, domain, myTags, readersTags, comments, token, onClickDelete, onClickEdit} = this.props
    const script = `<script src="https://ziltag.com/plugin.js" data-ziltag="${token}"></script>`
    return (
      <div className="ziltag-domain-info">
        <div className="ziltag-domain-info__data">
          <div className="ziltag-domain-info__home">{domain}</div>
          <div style={{marginTop: 16}}><WebsiteStats myTags={myTags} readersTags={readersTags} comments={comments} /></div>
          <div className="ziltag-domain-info__code">{script}</div>
        </div>
        <div className="ziltag-domain-info__actions">
          <div className="ziltag-domain-info__edit"></div>
          <div className="ziltag-domain-info__delete" onClick={_=>onClickDelete(id)}></div>
        </div>
      </div>
    )
  }
}

function mapDispatchToProps(dispatch) {
  return {
    onClickDelete: id => dispatch(openDialog('deleteWebsite', id))
  }
}

export default connect(null, mapDispatchToProps)(DomainInfo)