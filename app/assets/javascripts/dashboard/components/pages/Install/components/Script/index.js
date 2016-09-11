import React from 'react'
import './index.scss'
import Button from 'Button'
import ZeroClipboard from 'zeroclipboard'
import swfPath from 'zeroclipboard/dist/ZeroClipboard.swf'
import ReactDOM from 'react-dom'

export default class Script extends React.Component{
  componentDidMount () {
    ZeroClipboard.config({swfPath})
    new ZeroClipboard(ReactDOM.findDOMNode(this.refs.copy))
  }

  render(){
    const {token} = this.props
    const script = `<script src="//ziltag.com/plugin.js" data-ziltag="${token}"></script>`
    const buttonStyle = {
      width: 116,
      fontSize: 14,
      fontWeight: 500
    }
    return (
      <div className="ziltag-install-script">
        <div className="ziltag-install-script__text">
          <div className="ziltag-install-script__token">Plugin Token: <b>{token}</b></div>
          <div className="ziltag-install-script__script">{script}</div>
        </div>
        <Button style={buttonStyle} ref="copy" data-clipboard-text={script}>Copy Script</Button>
      </div>
    )
  }
}
