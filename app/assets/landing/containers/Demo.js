import {bindActionCreators} from 'redux'
import {connect} from 'react-redux'
import {openModal, closeDemo} from '../actions'
import Demo from '../components/Demo'

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Demo)

function mapStateToProps(state) {
  return {
    isOpen: state.demo.isOpen,
    url: state.demo.url,
    tip: state.demo.tip
  }
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({
    onClickSignUp: signUp,
    onClose: closeDemo
  }, dispatch)
}

function signUp() {
  return openModal('signUp')
}
