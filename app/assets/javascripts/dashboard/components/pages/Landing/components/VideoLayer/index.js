import Layer from '../../../../Layer'
import Video from '../Video'
import React from 'react'
import './index.scss'

export default ownProps => {
  const {open, onClickLayer, ...props} = ownProps
  return (
    <Layer open={open} onClick={onClickLayer}>
      <div className="ziltag-video-layer__video">
        <Video playerVars={{autoplay: 1}} {...props}/>
      </div>
    </Layer>
  )
}