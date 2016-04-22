import { MailBoard } from '../../../components/MessageBoard'
import ScriptCopy from '../../../components/ScriptCopy'
import InstallGuide from '../../../components/InstallGuide'
import './index.scss'

import React from 'react'

export default class Install extends React.Component {
  render () {
    return (
      <div className="ziltag-install">
        <div className="ziltag-install__container">
          <MailBoard />
          <ScriptCopy token="12345" website="http://tonytonyjan.net"/>
          <div className="ziltag-install__guide">
            <InstallGuide/>
          </div>
        </div>
      </div>
    )
  }
}