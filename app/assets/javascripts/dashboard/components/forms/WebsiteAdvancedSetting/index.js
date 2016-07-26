import React from 'react'
import './index.scss'
import Toggle from 'material-ui/Toggle'

export default props => {
  const {restricted, onToggle} = props
  return (
    <div className="website-advanced-setting">
      <div className="website-advanced-setting__title">Domain Advanced Settings</div>
      <div className="website-advanced-setting__switch">
        <Toggle
          label="Allow visitors to add tags on my images."
          labelPosition="right"
          defaultToggled={restricted}
          onToggle={onToggle}
          />
      </div>
    </div>
  )
}
