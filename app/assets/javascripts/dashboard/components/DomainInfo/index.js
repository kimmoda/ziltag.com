import './index.scss'
import React, { PropTypes } from 'react'
import {connect} from 'react-redux'
import {openDialog} from '../../actions'

class DomainInfo extends React.Component {
  render () {
    const {id, restricted, domain, myTags, readersTags, comments, onClickDelete, onClickEdit, onClickMore} = this.props
    return (
      <div className="ziltag-domain-info">
        <div className="ziltag-domain-info__data">
          <div className="ziltag-domain-info__home">{domain}</div>
        </div>
        <div className="ziltag-domain-info__actions">
          <div className="ziltag-domain-info__edit" onClick={_=>onClickEdit(id,domain)}></div>
          <div className="ziltag-domain-info__delete" onClick={_=>onClickDelete(id)}></div>
          <div className="ziltag-domain-info__more" onClick={_=>onClickMore(id, restricted)}></div>
        </div>
      </div>
    )
  }
}

function mapDispatchToProps(dispatch) {
  return {
    onClickEdit: (id, url) => dispatch(openDialog('updateWebsite', {id, url})),
    onClickDelete: id => dispatch(openDialog('deleteWebsite', id)),
    onClickMore: (id, restricted) => dispatch(openDialog('websiteAdvancedSetting', {id, restricted})),
  }
}

export default connect(null, mapDispatchToProps)(DomainInfo)
