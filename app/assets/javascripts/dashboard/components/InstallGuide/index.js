import './index.scss'
import React, { PropTypes } from 'react'

const guides = {
  general: [
    <li key="1" className="ziltag-install-guide__step">Copy the script.</li>,
    <li key="2" className="ziltag-install-guide__step">Paste before <b><code>&lt;/body&gt;</code></b> in your website.</li>
  ],
  tumblr: [
    <li key="1" className="ziltag-install-guide__step">Click user icon on the top-right corner and select <b>Edit appearance</b>.</li>,
    <li key="2" className="ziltag-install-guide__step">Click <b>Edit Theme</b> button under <b>Website Theme</b> tab.</li>,
    <li key="3" className="ziltag-install-guide__step">Click <b>Edit HTML</b>.</li>,
    <li key="4" className="ziltag-install-guide__step">Scroll the editor all the way down and paste the script before <b><code>&lt;/body&gt;</code></b></li>,
    <li key="5" className="ziltag-install-guide__step">Click <b>Update Preview</b>, then <b>Save</b>. Now You are all set.</li>
  ],
  blogger: [
    <li key="1" className="ziltag-install-guide__step">Go to the dashboard of your blog.</li>,
    <li key="2" className="ziltag-install-guide__step">Select <b>Template</b> on the side bar.</li>,
    <li key="3" className="ziltag-install-guide__step">Click <b>Edit HTML</b>.</li>,
    <li key="4" className="ziltag-install-guide__step">Scroll down and paste the script before <b><code>&lt;/body&gt;</code></b>.</li>,
    <li key="5" className="ziltag-install-guide__step">Click <b>Save template</b>, then Save. Now You are all set.</li>
  ]
}

export default class InstallGuide extends React.Component {
  static propTypes = {
    platform: React.PropTypes.oneOf(['general', 'tumblr', 'blogger']).isRequired,
  }

  static defaultProps = {
    platform: 'general'
  }

  render () {
    return (
      <div className="ziltag-install-guide">
        <div className="ziltag-install-guide__head">Installation guide</div>
        <div className="ziltag-install-guide__body">
          <ol className="ziltag-install-guide__steps">
            {guides[this.props.platform]}
          </ol>
          <iframe className="ziltag-install-guide__video" width="560" height="300" src="https://www.youtube.com/embed/M-r2lnyQ8-M?rel=0" frameBorder="0" allowFullScreen></iframe>
        </div>
      </div>
    )
  }
}