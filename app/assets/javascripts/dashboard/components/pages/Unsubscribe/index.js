import React from 'react'
import './index.scss'
import {connect} from 'react-redux'
import {push} from 'react-router-redux'
import {requestSubscribe} from 'actions'

export default connect(
  state => ({
    subscribed: state.unsubscribe.subscribed,
    error: state.unsubscribe.error,
  }),
  (dispatch, ownProps) => ({
    onClickUndo: () => dispatch(requestSubscribe(ownProps.location.query.token)),
    onClickToAccountPage: () => dispatch(push('dashboard/account'))
  })
)(props => (
  <div className="ziltag-pages-unsubscribe">
    <div className="ziltag-pages-unsubscribe__title">You’ve been unsubscribe from the discussion.</div>
    <div className="ziltag-pages-unsubscribe__subtitle">You will not receive update email from this thread.</div>
    <div className="ziltag-pages-unsubscribe__undo">
      {
        props.subscribed
        ? <div>Subscribed Successfully!</div>
        : <div>Unsubscribe by mistake? <b className="ziltag-pages-unsubscribe__undo-btn" onClick={props.onClickUndo}>UNDO</b></div>
      }
    </div>
    {props.error && <div className="ziltag-pages-unsubscribe__error">{props.error}</div>}
    <hr className="ziltag-pages-unsubscribe__hr"/>
    <div className="ziltag-pages-unsubscribe__footer">
      If you wish to turn off notification, click <b className="ziltag-pages-unsubscribe__back-account-btn" onClick={props.onClickToAccountPage}>here</b>.
    </div>
  </div>
))
