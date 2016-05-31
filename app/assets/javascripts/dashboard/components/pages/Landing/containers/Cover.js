import Cover from '../components/Cover'
import {connect} from 'react-redux'
import * as actions from '../../../../actions'

const coverHeight = 1197
const coverWidth = 2047
const coverRatio = coverHeight/coverWidth
const screenLeftRatio = 941/coverWidth
const screenTopRatio = 285/coverHeight
const screenWidthRatio = 832/coverWidth
const screenHeightRatio = 463/coverHeight

export default connect(
  state => {
    let {width: windowWidth, height: windowHeight} = state.window
    if(windowHeight < 800) windowHeight = 800
    const windowRatio = windowHeight/windowWidth
    let adjCoverHeight, adjCoverWidth, offsetTop, offsetLeft
    if(windowRatio > coverRatio){
      adjCoverHeight = windowHeight
      adjCoverWidth = adjCoverHeight / coverRatio
      offsetTop = 0
      offsetLeft = -(adjCoverWidth - windowWidth)/2
    } else {
      adjCoverWidth = windowWidth
      adjCoverHeight = adjCoverWidth * coverRatio
      offsetLeft = 0
      offsetTop = -(adjCoverHeight - windowHeight)/2
    }
    const left = adjCoverWidth*screenLeftRatio + offsetLeft
    const top = adjCoverHeight*screenTopRatio + offsetTop
    const width = adjCoverWidth*screenWidthRatio
    const height = adjCoverHeight*screenHeightRatio
    return {
      screen: {
        width,
        height,
        left,
        top
      }
    }
  },
  dispatch => ({
    onClickJoin: _ => dispatch(actions.openDialog('signUp')),
    onClickWatchVideo: _ => dispatch(actions.openVideoLayer('ic2-Ascvte4'))
  })
)(Cover)