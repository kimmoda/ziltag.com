import Bottom from '../components/Bottom'
import {connect} from 'react-redux'
import * as actions from '../../../../actions'

export default connect(
  null,
  dispatch => ({
    onClickJoin: _ => dispatch(actions.openDialog('signUp'))
  })
)(Bottom)