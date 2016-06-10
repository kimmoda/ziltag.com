import Cheer from '../../../components/Cheer'
import React from 'react'
import './index.scss'

export default class Verified extends React.Component {
  render () {
    return (
      <div className="ziltag-verified">
        <div className="ziltag-verified__cheer">
          <Cheer title="Password setup successfully" subtitle="Going to dashboard now."/>
        </div>
      </div>
    )
  }
}