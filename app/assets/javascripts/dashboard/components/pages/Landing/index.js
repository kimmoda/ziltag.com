import React from 'react'
import Header from '../../Header'
import Cover from './components/Cover'
import Feature from './components/Feature'
import Red from './components/Red'
import Install from './components/Install'
import './index.scss'

export default props => (
  <div className="ziltag-landing">
    <div className="ziltag-landing__header"><Header/></div>
    <Cover />
    <Feature />
    <Red />
    <Install />
  </div>
)