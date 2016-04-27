import './index.scss'
import React, { PropTypes } from 'react'
import ReactDOM from 'react-dom'
import ZeroClipboard from 'zeroclipboard'
import swfPath from 'zeroclipboard/dist/ZeroClipboard.swf'
import FlatButton from 'material-ui/FlatButton'

export default class ScriptCopy extends React.Component {
  static propTypes = {
    token: PropTypes.string.isRequired,
    website: PropTypes.string.isRequired
  }

  componentDidMount () {
    ZeroClipboard.config({swfPath})
    new ZeroClipboard(ReactDOM.findDOMNode(this.refs.copy))
  }

  render () {
    const script = `<script src="https://ziltag.com/plugin.js" data-ziltag="${this.props.token}"></script>`
    const copyButtonStyle = {
      width: 112,
      borderRight: 'solid 1px rgba(0, 0, 0, .12)',
      fontFamily: "'Roboto', sans-serif",
      fontSize: 16,
      fontWeight: 'normal'
    }
    const websiteButtonStyle = {
      width: 186,
      fontFamily: "'Roboto', sans-serif",
      fontSize: 16,
      fontWeight: 'normal',
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center'
    }
    return (
      <div className="ziltag-script-copy">
        <div
          className="ziltag-script-copy__script">
          {script}
        </div>
        <FlatButton
          ref="copy"
          data-clipboard-text={script}
          label="COPY"
          style={copyButtonStyle}
          />
        <FlatButton
          href={this.props.website}
          linkButton
          target="_blank"
          label="GO TO WEBSITE"
          style={websiteButtonStyle}
          />
      </div>
    )
  }
}