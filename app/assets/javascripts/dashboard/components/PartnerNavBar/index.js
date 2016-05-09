import PageBar from '../PageBar'
import WebsiteStats from '../WebsiteStats'
import * as actionTypes from '../../actions/types'
import './index.scss'

import React, { PropTypes } from 'react'
import {findDOMNode} from 'react-dom'
import {Popover, PopoverAnimationVertical} from 'material-ui/Popover'
import Menu from 'material-ui/Menu'
import MenuItem from 'material-ui/MenuItem'
import { connect } from 'react-redux'

class PartnerNavBar extends React.Component {

  static defaultProps = {
    isOpen: true,
  }

  render () {
    const {
      isOpen,
      selected,
      website,
      websites,
      menuTarget,
      myTags,
      readersTags,
      comments,
      onClickMenu,
      onRequestClose,
      onItemTouchTap,
      onMenuChange
    } = this.props
    let domainClass = 'ziltag-partner-nav-bar__domain'
    if(isOpen) domainClass += ' ziltag-partner-nav-bar__domain--active'

    const menuItemStyle = {
      fontFamily: "'Roboto', sans-serif",
      fontSize: 14,
      letterSpacing: .9,
      color: 'rgba(0, 0, 0, .87)',
      paddingLeft: 35
    }
    return (
      <div className="ziltag-partner-nav-bar">
        <PageBar>
          <div className={domainClass} onClick={onClickMenu}>{website.url}</div>
          <Popover
            open={isOpen}
            anchorEl={menuTarget}
            anchorOrigin={{horizontal: 'left', vertical: 'bottom'}}
            targetOrigin={{horizontal: 'left', vertical: 'top'}}
            onRequestClose={ onRequestClose }
            animation={PopoverAnimationVertical}
          >
            <Menu autoWidth={false} width={280} value={selected} onItemTouchTap={onItemTouchTap} onChange={onMenuChange}>
              {websites.map((website) => <MenuItem key={website.id} value={website.id}><div style={{...menuItemStyle}}>{website.url}</div></MenuItem>)}
            </Menu>
          </Popover>
          <div style={{marginLeft: 21}}>
            <WebsiteStats myTags={myTags} readersTags={readersTags} comments={comments} />
          </div>
        </PageBar>
      </div>
    )
  }
}

function mapStateToProps(state) {
  const me = state.entities.users[state.me]
  if(!me) return {}
  const website = state.entities.websites[state.siteMenu.selected]
  const myTags = website.ziltags.map(id => state.entities.ziltags[id])
  return {
    isOpen: state.siteMenu.open,
    selected: website.id,
    website,
    websites: me.websites.filter(id => id != state.siteMenu.selected).map(id => state.entities.websites[id]),
    menuTarget: state.siteMenu.target,
    myTags: website.ziltags.filter(id => state.entities.ziltags[id].usr.id == state.me).length,
    readersTags: website.ziltags.filter(id => state.entities.ziltags[id].usr.id != state.me).length,
    comments: website.comments.length
  }
}

function mapDispatchToProps(dispatch) {
  return {
    onClickMenu: (event) => {dispatch({type: actionTypes.OPEN_SITE_MENU, target: event.target})},
    onRequestClose: () => {dispatch({type: actionTypes.CLOSE_SITE_MENU})},
    onMenuChange: (event, value) => { dispatch({type: actionTypes.SELECT_SITE_MENU_ITEM, selected: value}) },
    onItemTouchTap: (event) => { dispatch({type: actionTypes.CLOSE_SITE_MENU}) },
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(PartnerNavBar)