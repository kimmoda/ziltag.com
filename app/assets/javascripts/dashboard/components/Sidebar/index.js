import SearchField from '../SearchField'
import Footer from '../Footer'
import './index.scss'

import React, {PropTypes} from 'react'
import Menu from 'material-ui/Menu'
import MenuItem from 'material-ui/MenuItem'
import { Link } from 'react-router'
import { connect } from 'react-redux'

class Sidebar extends React.Component {

  static propTypes = {
    showRecommendedTags: PropTypes.bool.isRequired
  }

  static defaultProps = {
    showRecommendedTags: false
  }

  render () {
    const { showRecommendedTags } = this.props
    const links = [
      { to: '/dashboard/account', name: 'Account', },
    ]
    if(showRecommendedTags) links.push({to: '/dashboard/recommended_tags', name: 'Recommended'})
    const menuItems = links.map((obj) => {
      return (
        <MenuItem key={obj.name}>
          <Link
            to={obj.to}
            className="ziltag-sidebar__link"
            activeClassName="ziltag-sidebar__link--active">{obj.name}</Link>
        </MenuItem>
      )
    })

    return(
      <div className="ziltag-sidebar">
        <div className="ziltag-sidebar__menu">
          <Menu
            autoWidth={false}
            style={{display: 'table', width: '100%'}}
            listStyle={{paddingTop: 0}}>
            {menuItems}
          </Menu>
        </div>
        <div className="ziltag-sidebar__footer">
          <Footer/>
        </div>
      </div>
    )
  }
}

function mapStateToProps(state) {
  const me = state.entities.users[state.me]
  return { showRecommendedTags: me ? me.isPartner : false }
}

export default connect(mapStateToProps, null, null, {pure: false})(Sidebar)
// # https://github.com/reactjs/react-redux/blob/v4.0.0/docs/troubleshooting.md#my-views-arent-updating-when-something-changes-outside-of-redux