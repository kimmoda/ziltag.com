import {connect} from 'react-redux'
import Checked from '../../components/modals/Checked'

export default connect(
  mapStateToProps
)(Checked)

function mapStateToProps(state) {
  return {
    message: state.modal.message
  }
}
