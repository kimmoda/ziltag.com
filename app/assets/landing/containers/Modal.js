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
    children: modals[state.modal] && createElement(modals[state.modal]),
    isOpen: modals[state.modal] && !!state.modal
  }
}

function mapDispatchToProps(dispatch){
  return bindActionCreators({
    onRequestClose: closeModal
  }, dispatch)
}
