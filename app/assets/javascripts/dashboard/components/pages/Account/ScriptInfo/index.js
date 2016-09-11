import React from 'react'
import ReactDOM from 'react-dom'
import Button from '../../../Button'
import ZeroClipboard from 'zeroclipboard'
import swfPath from 'zeroclipboard/dist/ZeroClipboard.swf'
import './index.scss'
import {connect} from 'react-redux'

const buttonStyle = {
  fontSize: 14,
  height: 39,
  fontWeight: 500
}

export default class ScriptInfo extends React.Component{
  componentDidMount () {
    ZeroClipboard.config({swfPath})
    new ZeroClipboard(ReactDOM.findDOMNode(this.refs.copy))
  }

  render(){
    const {token, onClickCopy} = this.props
    const script = `<script src="//ziltag.com/plugin.js" data-ziltag="${token}"></script>`
    return (
      <div className="ziltag-account-script-info">
        <div className="ziltag-account-script-info__body">
          <div className="ziltag-account-script-info__token">Plugin Token: <b>{token}</b></div>
          <div className="ziltag-account-script-info__script">{script}</div>
        </div>
        <div className="ziltag-account-script-info__copy-button">
          <Button style={buttonStyle} ref="copy" data-clipboard-text={script}>Copy Script</Button>
        </div>
      </div>
    )
  }
}