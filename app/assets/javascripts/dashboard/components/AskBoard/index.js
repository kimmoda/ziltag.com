import React, { PropTypes } from 'react'
import Button from '../../components/Button'
import './index.scss'

const buttonStyle = {
  fontSize: 23.84,
  letterSpacing: 2.18,
  height: 70
}

export default props => {
  return (
    <div className="ziltag-ask-board">
      <div className="ziltag-ask-board__question">{props.question}</div>
      <div className="ziltag-ask-board__buttons">
        <div className="ziltag-ask-board__button">
          <Button backgroundColor="#979797" style={buttonStyle} onClick={_ => props.onNo(props.payload)}>NO</Button>
        </div>
        <div className="ziltag-ask-board__button">
          <Button backgroundColor="#008BF3" style={buttonStyle} onClick={_ => props.onYes(props.payload)}>YES</Button>
        </div>
      </div>
    </div>
  )
}