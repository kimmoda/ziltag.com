import React from 'react'
import { Link } from 'react-router'
import IconMenu from 'material-ui/IconMenu'
import MenuItem from 'material-ui/MenuItem'
import IconButton from 'material-ui/IconButton/IconButton'

export default function(props){
  const {avatarURL, onClickSignOut} = props
  return(
    <IconMenu
      iconButtonElement={
        <IconButton
          iconClassName="ziltag-header__avatar"
          style={{width: 40, height: 40, padding: 30}}
          iconStyle={{backgroundImage: `url("${avatarURL}")`}}/>
        // TODO //github.com/callemall/material-ui/issues/2913
      }
      anchorOrigin={{horizontal: 'right', vertical: 'bottom'}}
      targetOrigin={{horizontal: 'right', vertical: 'top'}}
      >
      <Link className="ziltag-header__link" to="/dashboard"><MenuItem primaryText="Dashboard" /></Link>
      <Link className="ziltag-header__link" to="/dashboard/guide"><MenuItem primaryText="Guide" /></Link>
      <MenuItem style={{cursor: 'pointer'}} primaryText="Sign out" onClick={onClickSignOut} />
    </IconMenu>
  )
}
