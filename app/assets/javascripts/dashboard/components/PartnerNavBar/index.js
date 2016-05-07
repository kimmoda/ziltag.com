import PageBar from '../PageBar'
import WebsiteStats from '../WebsiteStats'
import * as actionTypes from '../../actions/types'
import './index.scss'

import React, { PropTypes } from 'react'
import {Popover, PopoverAnimationVertical} from 'material-ui/Popover'
import Menu from 'material-ui/Menu'
import MenuItem from 'material-ui/MenuItem'
import { connect } from 'react-redux'

class PartnerNavBar extends React.Component {
  static propTypes = {
    isOpen: PropTypes.bool,
    selected: PropTypes.number,
    websites: PropTypes.array,
    onClickMenu: PropTypes.func,
    onRequestClose: PropTypes.func,
    onMenuChange: PropTypes.func,
    onItemTouchTap: PropTypes.func,
  }

  static defaultProps = {
    isOpen: true,
  }

  render () {
    const {
      isOpen,
      selected,
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
          <div ref="domain" className={domainClass} onClick={onClickMenu}>{websites[selected].url}</div>
          <Popover
            open={isOpen}
            anchorEl={menuTarget}
            anchorOrigin={{horizontal: 'left', vertical: 'bottom'}}
            targetOrigin={{horizontal: 'left', vertical: 'top'}}
            onRequestClose={ onRequestClose }
            animation={PopoverAnimationVertical}
          >
            <Menu autoWidth={false} width={280} value={selected} onItemTouchTap={onItemTouchTap} onChange={onMenuChange}>
              { websites.map((website, idx) => <MenuItem key={website.id} value={idx}><div style={{...menuItemStyle}}>{website.url}</div></MenuItem>).filter((website, idx) => idx != selected) }
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
  return {
    isOpen: state.siteMenu.open,
    menuTarget: state.siteMenu.target,
    websites: state.me ? state.me.websites : [],
    selected: state.siteMenu.selected,
    myTags: state.me ? state.me.websites[state.siteMenu.selected].ziltags.filter(ziltag => ziltag.usr.name == state.me.name).length : null,
    readersTags: state.me ? state.me.websites[state.siteMenu.selected].ziltags.filter(ziltag => ziltag.usr.name != state.me.name).length : null,
    comments: state.me ? state.me.websites[state.siteMenu.selected].comments.length : null
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