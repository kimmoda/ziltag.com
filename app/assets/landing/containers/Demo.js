import {bindActionCreators} from 'redux'
import {connect} from 'react-redux'
import {openModal, closeDemo} from '../actions'
import Demo from '../components/Demo'

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Demo)

function mapStateToProps(state) {
  return state.demo
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
