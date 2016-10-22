import React, {PropTypes} from 'react'
import Close from 'react-icons/lib/md/close'
import Button from 'ziltag-elements/dist/Button'
import translate from 'hoc/translate'

import './index.css'

const Demo = props => {
  const {isOpen, url, onClose, onClickSignUp, tip, t} = props
  return isOpen && (
    <div className="l-demo">
      <iframe className="l-demo__iframe" src={`https://preview.ziltag.com?url=${encodeURIComponent(url)}`}/>
      <div className="l-demo__header">
        <div className="l-demo__left-container">
          <div className="l-demo__logo"/>
          <div className="l-demo__title">{t('demo')}</div>
        </div>
        <div className="l-demo__right-container">
          <Button text={t('join_now')} onClick={onClickSignUp}/>
          <Close className="l-demo__close" size={40} onClick={onClose}/>
        </div>
      </div>
      <div className="l-demo__tip">
        <div className="l-demo__tip-title">{t('tip')}</div>
        <div className="l-demo__tip-text">{t(tip)}</div>
      </div>
    </div>
  )
}

Demo.propTypes = {
  isOpen: PropTypes.bool,
  url: PropTypes.string,
  onClose: PropTypes.func,
  onClickSignUp: PropTypes.func,
  tip: PropTypes.string
}

Demo.defaultProps = {
  isOpen: true
}

export default translate(Demo)
