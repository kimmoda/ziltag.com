import Header from '../Header'
import Sidebar from '../Sidebar'
import DevTools from '../../containers/DevTools'
import './index.scss'
import 'normalize.css/normalize.css'

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
        {__PRODUCTION__ ? null : <DevTools/>}
      </div>
    )
  }
}