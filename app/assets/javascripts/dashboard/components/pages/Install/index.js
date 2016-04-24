import { MailBoard } from '../../../components/MessageBoard'
import ScriptCopy from '../../../components/ScriptCopy'
import InstallGuide from '../../../components/InstallGuide'
import './index.scss'

import React from 'react'
import { connect } from 'react-redux'

class Install extends React.Component {
  render () {
    return (
      <div className="ziltag-install">
        <div className="ziltag-install__container">
          <MailBoard subtitle={this.props.confirmed ? "Copy the script below and install Ziltag Plugin to your website." : "We’ve sent you an email for verification. Please check your inbox."}/>
          {this.props.token && this.props.website ? <ScriptCopy token={this.props.token} website={this.props.website}/> : null}
          <div className="ziltag-install__guide">
            <InstallGuide platform={this.props.platform} />
          </div>
        </div>
      </div>
    )
  }
}

function mapStateToProps(state) {
    if (state.me && state.me.website) {
        let {
            website: {
                token,
                url: website,
                platform
            },
            confirmed
        } = state.me
        return {token, website, platform, confirmed}
    } else
        return {}
    }

export default connect(mapStateToProps)(Install)