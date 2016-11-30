import {closeModal} from 'actions'
import * as modals from '../modals'

import Modal from 'ziltag-elements/dist/Modal'
import {createElement} from 'react'
import {connect} from 'react-redux'
import {bindActionCreators} from 'redux'

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Modal)

function mapStateToProps(state){
  return {
    mode: state.modal.mode,
    children: modals[state.modal.name] && createElement(modals[state.modal.name]),
    isOpen: modals[state.modal.name] && !!state.modal.name,
    size: state.modal.size,
    showClose: state.modal.showClose,
    overlayClose: state.modal.overlayClose
  }
}

function mapDispatchToProps(dispatch){
  return bindActionCreators({
    onRequestClose: closeModal
  }, dispatch)
}
