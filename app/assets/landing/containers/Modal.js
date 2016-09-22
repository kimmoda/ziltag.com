import {closeModal} from 'actions'

import Modal from 'ziltag-elements/dist/Modal'
import {connect} from 'react-redux'
import {bindActionCreators} from 'redux'

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Modal)

function mapStateToProps(state){
  return {
    isOpen: !!state.modal
  }
}

function mapDispatchToProps(dispatch){
  return bindActionCreators({
    onRequestClose: closeModal
  }, dispatch)
}
