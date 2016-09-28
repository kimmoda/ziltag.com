import {openModal} from '../actions'
import Button from 'ziltag-elements/dist/Button'
import {connect} from 'react-redux'
import {bindActionCreators} from 'redux'
import React from 'react'

export default connect(
  null,
  mapDispatchToProps
)(ModalButton)

function mapDispatchToProps(dispatch, ownProps){
  return bindActionCreators({
    openModal
  }, dispatch)
}

function ModalButton(props){
  const {modalName, modalMode, openModal, ...others} = props
  return <Button onClick={() => openModal(modalName, modalMode)} {...others}/>
}
