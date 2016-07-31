import React from 'react'
import './index.scss'
import SettingSection, {SectionBody} from 'SettingSection'
import Toggle from 'material-ui/Toggle'
import {connect} from 'react-redux'
import {requestUpdateZiltagNotification, requestUpdateCommentNotification} from 'actions'

const toggleStyle = {
  marginTop: 20,
  color: 'rgba(0,0,0,.87)',
  fontSize: 14
}

export default connect(
  state => ({
    ziltagNotification: state.entities.users[state.me].ziltagNotification,
    commentNotification: state.entities.users[state.me].commentNotification
  }),
  dispatch => ({
    onToggleZiltagNotification: event => dispatch(requestUpdateZiltagNotification(event.target.checked)),
    onToggleCommentNotification: event => dispatch(requestUpdateCommentNotification(event.target.checked))
  })
)(props => (
  <SettingSection title="My plugin">
    <SectionBody>
      <div className="ziltag-notification-setting__text">Receive notification email when:</div>
      <Toggle
        style={toggleStyle}
        label="New ziltag has been added to my image."
        labelPosition="right"
        defaultToggled={props.ziltagNotification}
        onToggle={props.onToggleZiltagNotification}
      />
      <Toggle
        style={toggleStyle}
        label="New comment has been posted."
        labelPosition="right"
        defaultToggled={props.commentNotification}
        onToggle={props.onToggleCommentNotification}
      />
    </SectionBody>
  </SettingSection>
))
