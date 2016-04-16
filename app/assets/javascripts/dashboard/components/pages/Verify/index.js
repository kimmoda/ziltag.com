import {CheerBoard} from '../../../components/MessageBoard'
import './index.scss'
import React from 'react'

export default class Verify extends React.Component {
  render () {
    return(
      <div className="ziltag-verify">
        <CheerBoard />
      </div>
    )
  }
}