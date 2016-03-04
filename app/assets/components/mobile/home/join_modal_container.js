import {connect} from 'react-redux'
import JoinModal from './join_modal.js'

function mapStateToProps(state) {
  return {
    select: state.platform,
    error: state.error
  }
}

function mapDispatchToProps(dispatch) {
  return {
    onSelectPlatform: (platform) => {
      dispatch({type: 'SELECT_PLATFORM', platform: platform})
    }
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(JoinModal)