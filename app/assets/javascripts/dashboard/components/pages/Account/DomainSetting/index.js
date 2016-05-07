import SettingSection, {SectionBody} from '../../../SettingSection'
import DomainInfo from '../../../DomainInfo'
import React, { PropTypes } from 'react'
import {connect} from 'react-redux'

class DomainSetting extends React.Component {
  render () {
    const {websites, username} = this.props
    const domainInfoElements = websites.map(website => (
      <SectionBody key={website.id}>
        <DomainInfo
          domain={website.url}
          token={website.token}
          myTags={website.ziltags.filter(ziltag => ziltag.usr.name == username).length}
          readersTags={website.ziltags.filter(ziltag => ziltag.usr.name != username).length}
          comments={website.comments.length}/>
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
  return {
    websites: state.me ? state.me.websites : [],
    username: state.me ? state.me.name : null
  }
}

export default connect(mapStateToProps)(DomainSetting)