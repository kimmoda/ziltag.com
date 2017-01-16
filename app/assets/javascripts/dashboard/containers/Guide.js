import Guide from '../components/Guide'
import * as actions from '../actions'
import {connect} from 'react-redux'

export default connect(
  null,
  dispatch => ({
    onClickVideo: _ => dispatch(actions.openIframeModal('//www.youtube.com/embed/fnxdl83iBcE?rel=0&amp;showinfo=0'))
  })
)(Guide)
