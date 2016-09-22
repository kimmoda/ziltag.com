import {openModal} from '../actions'
import Button from 'ziltag-elements/dist/Button'
import {connect} from 'react-redux'
import {bindActionCreators} from 'redux'

export default connect(
  null,
  mapDispatchToProps
)(Button)

function mapDispatchToProps(dispatch){
  return bindActionCreators({
    onClick: openSignUpModal
  }, dispatch)
}

function openSignUpModal(){
  return openModal('signUp')
}
