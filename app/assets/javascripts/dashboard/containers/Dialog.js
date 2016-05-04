import Dialog from '../components/Dialog'
import * as actions from '../actions'
import {connect} from 'react-redux'

function mapStateToProps(state) {
  if (state.dialog)
    return {
      open: true,
      name: state.dialog
    }
  else return {
    open: false
  }
}

function mapDispatchToProps(dispatch) {
  return {
    onClose: _ => dispatch(actions.closeDialog())
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(Dialog)