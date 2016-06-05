import Header from '../Header'
import Sidebar from '../Sidebar'
import IframeModal from '../IframeModal'
import Dialog from '../../containers/Dialog'
import DevTools from '../../containers/DevTools'
import './index.scss'
import 'normalize.css/normalize.css'
import 'slick-carousel/slick/slick.scss'
import 'slick-carousel/slick/slick-theme.scss'
import 'highlight.js/styles/rainbow.css'

import React from 'react'

export default class Dashboard extends React.Component {
  render () {
    return(
      <div className="ziltag-dashboard">
        <div className="ziltag-dashboard__header">
          <Header/>
        </div>
        <div className="ziltag-dashboard__sidebar">
          <Sidebar/>
        </div>
        <div className="ziltag-dashboard__content">
          {this.props.children}
        </div>
        <IframeModal/>
        <Dialog/>
        {__PRODUCTION__ ? null : <DevTools/>}
      </div>
    )
  }
}