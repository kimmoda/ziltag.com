import VideoLayer from '../components/VideoLayer'
import {connect} from 'react-redux'
import * as actions from '../../../../actions'

export default connect(
  state => ({
    open: state.videoLayer.open,
    layer: state.videoLayer.state == 'pause' || state.videoLayer.state == 'end',
    watch: state.videoLayer.state == 'begin',
    resume: state.videoLayer.state == 'pause',
    replay: state.videoLayer.state == 'end',
    join: state.videoLayer.state == 'pause' || state.videoLayer.state == 'end',
  }),
  dispatch => ({
    onClickLayer: _ => {
      dispatch(actions.closeVideoLayer())
    },
    onWatch: instance => {
      instance.playVideo()
      dispatch(actions.playVideoLayer())
    },
    onResume: instance => {
      instance.playVideo()
      dispatch(actions.playVideoLayer())
    },
    onReplay: instance => {
      instance.playVideo()
      dispatch(actions.playVideoLayer())
    },
    onPause: _ => dispatch(actions.pauseVideoLayer()),
    onJoin: _ => dispatch(actions.openDialog('signUp')),
    onEnd: _ => dispatch(actions.endVideoLayer()),
  })
)(VideoLayer)