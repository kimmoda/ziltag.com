import './index.scss'
import React, { PropTypes } from 'react'

export default class ScriptCopy extends React.Component {
  static propTypes = {
    token: PropTypes.string.isRequired,
    website: PropTypes.string.isRequired
  }

  render () {
    return (
      <div className="ziltag-script-copy">
        <div className="ziltag-script-copy__script">
          {`<script src="https://ziltag.com/plugin.js" data-ziltag="${this.props.token}"></script>`}
        </div>
        <div className="ziltag-script-copy__copy">COPY</div>
        <a
          className="ziltag-script-copy__website"
          href={this.props.website}
          target="_blank">
          GO TO WEBSITE
        </a>
      </div>
    )
  }
}