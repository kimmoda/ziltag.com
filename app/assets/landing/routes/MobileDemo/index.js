import React from 'react'
import {bindActionCreators} from 'redux'
import {connect} from 'react-redux'
import translate from 'hoc/translate'
import './index.css'
import FieldButton from 'ziltag-elements/dist/FieldButton'
import {requestDemoLink} from '../../actions'

const MobileDemo = props => {
  const {name, t, onRequestSend} = props
  return (
    <div className="m-demo">
      <div className="m-demo__logo"/>
      <div className="m-demo__title">Hello{name && ` ${name}`}!</div>
      <div className="m-demo__body">{t('welcome_to_ziltag_demo')}</div>
      <div className="m-demo__button-wrapper">
        <form onSubmit={preventDefault}>
          <FieldButton
            name="url"
            buttonText={t('send_link')}
            placeholder={t('please_enter_your_email')}
            type="email"
            defaultWidth={210}
            extendedWidth={240}
            onRequestSend={onRequestSend}
            required
            />
          <button style={{display: 'none'}}/>
        </form>
      </div>
    </div>
  )
}

export default connect(null, mapDispatchToProps)(translate(MobileDemo))

function preventDefault(e){e.preventDefault()}

function mapDispatchToProps(dispatch, ownProps) {
  return bindActionCreators({
    onRequestSend: email => requestDemoLink(email, ownProps.location.query.preview)
  }, dispatch)
}
