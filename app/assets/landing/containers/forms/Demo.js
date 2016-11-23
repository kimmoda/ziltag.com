import {bindActionCreators} from 'redux'
import {connect} from 'react-redux'
import {requestShortenURL} from '../../actions'
import Demo from '../../components/forms/Demo'

export default connect(mapStateToProps, mapDispatchToProps)(Demo)

function mapStateToProps(state){
  return {
    defaultWidth: state.window.width >= 2048 ? '11vw' : undefined,
    extendedWidth: state.window.width >= 2048 ? '30vw' : (state.window.width <= 650 ? 210 : undefined)
  }
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({
    onRequestSend: requestShortenURL
  }, dispatch)
}
