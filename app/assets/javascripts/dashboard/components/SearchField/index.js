import './index.scss'
import React from 'react'

export default class SearchField extends React.Component {
  render () {
    return(
      <div className="ziltag-search-field">
        <input className="ziltag-search-field__input" type="text" placeholder="Search..." />
      </div>
    )
  }
}