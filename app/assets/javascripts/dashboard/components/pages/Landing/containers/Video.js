import Video from '../components/Video'
import {connect} from 'react-redux'
import * as actions from '../../../../actions'

export default connect(
  state => ({
    layer: state.video == 'pause' || state.video == 'end',
    watch: state.video == 'begin',
    resume: state.video == 'pause',
    replay: state.video == 'end',
    join: state.video == 'pause' || state.video == 'end',
  }),
  dispatch => ({
    onWatch: instance => {
      instance.playVideo()
      dispatch(actions.playVideo())
    },
    onResume: instance => {
      instance.playVideo()
      dispatch(actions.playVideo())
    },
    onReplay: instance => {
      instance.playVideo()
      dispatch(actions.playVideo())
    },
    onPause: _ => dispatch(actions.pauseVideo()),
    onJoin: _ => dispatch(actions.openDialog('signUp')),
    onEnd: _ => dispatch(actions.endVideo()),
  })
)(Video)