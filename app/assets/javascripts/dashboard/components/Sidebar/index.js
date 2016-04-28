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
            {
              showRecommendedTags ?
              <MenuItem>
                <Link
                  to="/recommended_tags"
                  className="ziltag-sidebar__link"
                  activeClassName="ziltag-sidebar__link--active">RecommendedTags</Link>
              </MenuItem>
              :
              null
            }
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
  return { showRecommendedTags: state.me ? state.me.confirmed : false }
}

export default connect(mapStateToProps, null, null, {pure: false})(Sidebar)
// # https://github.com/reactjs/react-redux/blob/v4.0.0/docs/troubleshooting.md#my-views-arent-updating-when-something-changes-outside-of-redux