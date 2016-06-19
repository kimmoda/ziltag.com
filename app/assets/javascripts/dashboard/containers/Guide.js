import Guide from '../components/Guide'
import * as actions from '../actions'
import {connect} from 'react-redux'

export default connect(
  null,
  dispatch => ({
    onClickVideo: _ => dispatch(actions.openIframeModal('https://www.youtube.com/embed/M-r2lnyQ8-M?rel=0&amp;showinfo=0'))
  })
)(Guide)