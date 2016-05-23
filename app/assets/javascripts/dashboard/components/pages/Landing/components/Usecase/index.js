import React from 'react'
import classNames from 'classnames'
import './index.scss'

export default props => {
  const {link, icon, name} = props
  const iconClass = classNames('ziltag-landing-usecase__icon', {
    'ziltag-landing-usecase__icon--map': icon == 'map',
    'ziltag-landing-usecase__icon--pie': icon == 'pie',
    'ziltag-landing-usecase__icon--notebook': icon == 'notebook'
  })
  return (
    <div className="ziltag-landing-usecase">
      <a href={link || '#'} className="ziltag-landing-usecase__link" target="_blank">
        <div className={iconClass} />
        <div className="ziltag-landing-usecase__name">{name}</div>
      </a>
    </div>
  )
}