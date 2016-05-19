import React from 'react'
import Header from '../../Header'
import Cover from './components/Cover'
import Feature from './components/Feature'
import Red from './components/Red'
import Install from './components/Install'
import Black from './components/Black'
import Bottom from './components/Bottom'
import Footer from './components/Footer'
import DevTools from '../../../containers/DevTools'
import './index.scss'

export default props => (
  <div className="ziltag-landing">
    <div className="ziltag-landing__header"><Header/></div>
    <Cover/>
    <Feature/>
    <Red/>
    <Install/>
    <Black/>
    <Bottom/>
    <Footer/>
    {__PRODUCTION__ ? null : <DevTools/>}
  </div>
)