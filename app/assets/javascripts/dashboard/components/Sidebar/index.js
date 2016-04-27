import SearchField from '../SearchField'
import Footer from '../Footer'
import './index.scss'

import React from 'react'
import Menu from 'material-ui/Menu'
import MenuItem from 'material-ui/MenuItem'
import { Link } from 'react-router'

export default class Sidebar extends React.Component {
  render () {
    return(
      <div className="ziltag-sidebar">
        <SearchField />
        <div className="ziltag-sidebar__menu">
          <Menu
            autoWidth={false}
            style={{display: 'table', width: '100%'}}
            listStyle={{paddingTop: 0}}>
            <MenuItem>
              <Link
                to="/tags"
                className="ziltag-sidebar__link"
                activeClassName="ziltag-sidebar__link--active">Tags</Link>
            </MenuItem>
            <MenuItem>
              <Link
                to="/comments"
                className="ziltag-sidebar__link"
                activeClassName="ziltag-sidebar__link--active">Comments</Link>
            </MenuItem>
            <MenuItem>
              <Link
                to="/account"
                className="ziltag-sidebar__link"
                activeClassName="ziltag-sidebar__link--active">Account</Link>
            </MenuItem>
          </Menu>
        </div>
        <div className="ziltag-sidebar__footer">
          <Footer/>
        </div>
      </div>
    )
  }
}