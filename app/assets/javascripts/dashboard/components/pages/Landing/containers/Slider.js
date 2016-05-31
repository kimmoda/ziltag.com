import Slider from '../components/Slider'
import {connect} from 'react-redux'
import * as actions from '../../../../actions'

export default connect(
  null,
  dispatch => ({
    onClickZiltag: (ziltagID) => dispatch(actions.openIframeModal(`https://ziltag.com/ziltags/${ziltagID}`))
  })
)(Slider)