import PageBar from '../PageBar'
import './index.scss'

import React, { PropTypes } from 'react'
import { Link } from 'react-router'

class PartnerNavBar extends React.Component {
  render () {
    return (
      <div className="ziltag-partner-nav-bar">
        <PageBar>
          <div className="ziltag-partner-nav-bar__domain">http://tonytonyjan.net</div>
          <div className="ziltag-partner-nav-bar__stats">
            <div className="ziltag-partner-nav-bar__stats-item">
              My tags: <Link className="ziltag-partner-nav-bar__link" to="/tags">25</Link>
          </div>
          <div className="ziltag-partner-nav-bar__stats-item">
            Reader’s tags: <Link className="ziltag-partner-nav-bar__link" to="/tags">3</Link>
          </div>
          <div className="ziltag-partner-nav-bar__stats-item">
            Comments: <Link className="ziltag-partner-nav-bar__link" to="/comments">10</Link>
          </div>
        </div>
      </PageBar>
    </div>
    )
  }
}

export default PartnerNavBar