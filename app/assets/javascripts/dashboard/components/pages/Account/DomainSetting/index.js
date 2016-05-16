import SettingSection, {SectionBody} from '../../../SettingSection'
import DomainInfo from '../../../DomainInfo'
import {openDialog} from '../../../../actions'
import React, { PropTypes } from 'react'
import FlatButton from 'material-ui/FlatButton'
import {connect} from 'react-redux'

class DomainSetting extends React.Component {
  render () {
    const {websites, onClickAdd} = this.props
    const domainInfoElements = websites.map(website => (
      <SectionBody key={website.id}>
        <DomainInfo
          id={website.id}
          domain={website.url}
          token={website.token}
          myTags={website.myTags}
          readersTags={website.readersTags}
          comments={website.comments}/>
      </SectionBody>
    ))
    const addDomain = <FlatButton
      label="＋ Add domain"
      onTouchTap={onClickAdd}
      style={{
        fontSize: 14,
        color: 'rgba(0, 0, 0, .87)',
        fontFamily: "'Roboto', sans-serif",
        fontWeight: 500
      }}
      />
    return (
      <SettingSection title="My plugin" right={addDomain}>
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
    websites: websites.filter(website=>!website.delete)
  }
}

function mapDispatchToProps(dispatch) {
  return {
    onClickAdd: () => dispatch(openDialog('addDomain'))
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(DomainSetting)