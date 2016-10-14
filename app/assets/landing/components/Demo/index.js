import React, {PropTypes} from 'react'
import Close from 'react-icons/lib/md/close'
import Button from 'ziltag-elements/dist/Button'
import './index.css'

const Demo = props => {
  const {isOpen, url, onClose, onClickSignUp} = props
  return isOpen && (
    <div className="l-demo">
      <iframe className="l-demo__iframe" src={`https://preview.ziltag.com?url=${encodeURIComponent(url)}`}/>
      <div className="l-demo__header">
        <div className="l-demo__left-container">
          <div className="l-demo__logo"/>
          <div className="l-demo__title">Demo</div>
        </div>
        <div className="l-demo__right-container">
          <Button text="Sign Up" onClick={onClickSignUp}/>
          <Close className="l-demo__close" size={40} onClick={onClose}/>
        </div>
      </div>
    </div>
  )
}

Demo.propTypes = {
  isOpen: PropTypes.bool,
  url: PropTypes.string,
  onClose: PropTypes.func,
  onClickSignUp: PropTypes.func
}

Demo.defaultProps = {
  isOpen: true
}

export default Demo
