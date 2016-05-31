import ZiltagMapTile from '../components/ZiltagMapTile'
import * as actions from '../actions'
import { connect } from 'react-redux'

function mapDispatchToProps(dispatch) {
  return {
    onClickZiltag: (ziltagID) => dispatch(actions.openIframeModal(`/ziltags/${ziltagID}`))
  }
}

export default connect(null, mapDispatchToProps)(ZiltagMapTile)