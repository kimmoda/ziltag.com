import Install from '../components/Install'
import {connect} from 'react-redux'
import * as actions from '../../../../actions'

export default connect(
  null,
  dispatch => ({
    onClickWatchVideo: _ => dispatch(actions.openVideoLayer('M-r2lnyQ8-M'))
  })
)(Install)