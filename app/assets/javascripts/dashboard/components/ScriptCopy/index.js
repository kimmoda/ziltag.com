import './index.scss'
import React, { PropTypes } from 'react'
import ZeroClipboard from 'zeroclipboard'
import swfPath from 'zeroclipboard/dist/ZeroClipboard.swf'

export default class ScriptCopy extends React.Component {
  static propTypes = {
    token: PropTypes.string.isRequired,
    website: PropTypes.string.isRequired
  }

  componentDidMount () {
    ZeroClipboard.config({swfPath})
    new ZeroClipboard(this.refs.copy)
  }

  render () {
    const script = `<script src="https://ziltag.com/plugin.js" data-ziltag="${this.props.token}"></script>`
    return (
      <div className="ziltag-script-copy">
        <div
          className="ziltag-script-copy__script"
          ref="script">
          {script}
        </div>
        <div
          className="ziltag-script-copy__copy"
          ref="copy"
          data-clipboard-text={script}>COPY</div>
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