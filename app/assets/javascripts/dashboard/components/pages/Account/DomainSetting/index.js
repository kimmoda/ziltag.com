import SettingSection, {SectionBody} from '../../../SettingSection'
import DomainInfo from '../../../DomainInfo'
import React, { PropTypes } from 'react'
import {connect} from 'react-redux'

class DomainSetting extends React.Component {
  render () {
    const {websites} = this.props
    const domainInfoElements = websites.map(website => (
      <SectionBody key={website.id}>
        <DomainInfo
          domain={website.url}
          token={website.token}
          myTags={website.myTags}
          readersTags={website.readersTags}
          comments={website.comments} />
      </SectionBody>
    ))
    return (
      <SettingSection title="My plugin" right="right">
        {domainInfoElements}
      </SettingSection>
    )
  }
}

function mapStateToProps(state) {
  const me = state.entities.users[state.me]
  const websites = me.websites.map(id => {
    const website = state.entities.websites[id]
    const myTags = website.ziltags.filter(id => state.entities.ziltags[id].usr.id == state.me).length
    const readersTags = website.ziltags.filter(id => state.entities.ziltags[id].usr.id != state.me).length
    const comments = website.comments.length
    return {...website, myTags, readersTags, comments}
  })
  return {
    websites
  }
}

export default connect(mapStateToProps)(DomainSetting)