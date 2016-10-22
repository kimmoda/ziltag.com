import {bindActionCreators} from 'redux'
import {connect} from 'react-redux'
import {openDemo} from '../../actions/demo'
import Demo from '../../components/forms/Demo'

export default connect(null, mapDispatchToProps)(Demo)

function mapDispatchToProps(dispatch) {
  return bindActionCreators({
    onRequestSend: demo
  }, dispatch)
}


function demo(url){
  return openDemo(url)
}
