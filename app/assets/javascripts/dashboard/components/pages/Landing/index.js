import React from 'react'
import Header from '../../Header'
import Cover from './components/Cover'
import './index.scss'

export default props => (
  <div className="ziltag-landing">
    <div className="ziltag-landing__header"><Header/></div>
    <Cover />
  </div>
)