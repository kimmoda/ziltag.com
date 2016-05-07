import SettingSection, {SectionBody} from '../../../SettingSection'
import DomainInfo from '../../../DomainInfo'
import React, { PropTypes } from 'react'
import {connect} from 'react-redux'

class DomainSetting extends React.Component {
  render () {
    const {websites} = this.props
    const domainInfoElements = websites.map(website => (
      <SectionBody key={website.id}>
        <DomainInfo domain={website.url} />
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
    websites: state.me ? state.me.websites : []
  }
}

export default connect(mapStateToProps)(DomainSetting)