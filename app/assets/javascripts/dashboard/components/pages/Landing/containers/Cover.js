import Cover from '../components/Cover'
import {connect} from 'react-redux'
import * as actions from '../../../../actions'

export default connect(
  null,
  dispatch => ({
    onClickJoin: _ => dispatch(actions.openDialog('signUp')),
    onClickWatchVideo: _ => dispatch(actions.openVideoLayer())
  })
)(Cover)