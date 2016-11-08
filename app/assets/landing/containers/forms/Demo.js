import {bindActionCreators} from 'redux'
import {connect} from 'react-redux'
import {requestShortenURL} from '../../actions'
import Demo from '../../components/forms/Demo'

export default connect(mapStateToProps, mapDispatchToProps)(Demo)

function mapStateToProps(state){
  return {
    extendedWidth: state.window.width <= 650 ? 210 : undefined
  }
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({
    onRequestSend: requestShortenURL
  }, dispatch)
}
