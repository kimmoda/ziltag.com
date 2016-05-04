import Dialog from '../components/Dialog'
import * as actions from '../actions'
import {connect} from 'react-redux'

function mapStateToProps(state) {
  return {
    open: !!state.dialog
  }
}

function mapDispatchToProps(dispatch) {
  return {
    onClose: _ => dispatch(actions.closeDialog())
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(Dialog)