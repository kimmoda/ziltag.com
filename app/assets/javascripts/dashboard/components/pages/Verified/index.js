import './index.scss'
import { CheerBoard } from '../../../components/MessageBoard'
import React from 'react'

export default class Verified extends React.Component {
  render () {
    return (
      <div className="ziltag-verified">
        <CheerBoard title="Password successfully setup." subtitle="We will lead you to your dashboard now."/>
      </div>
    )
  }
}