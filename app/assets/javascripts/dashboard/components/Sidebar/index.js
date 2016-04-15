import SearchField from '../SearchField'
import {default as Menu, MenuItem} from '../Menu'
import Footer from '../Footer'
import './index.scss'

import React from 'react'

export default class Sidebar extends React.Component {
  render () {
    return(
      <div className="ziltag-sidebar">
        <SearchField />
        <div className="ziltag-sidebar__menu">
          <Menu>
            <MenuItem to="/dashboard/tags">Tags</MenuItem>
            <MenuItem to="/dashboard/comments">Comments</MenuItem>
            <MenuItem to="/dashboard/account">Account</MenuItem>
          </Menu>
        </div>
        <div className="ziltag-sidebar__footer">
          <Footer/>
        </div>
      </div>
    )
  }
}