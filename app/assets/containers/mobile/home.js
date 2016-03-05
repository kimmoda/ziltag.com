import {connect} from 'react-redux'
import Home from '../../components/mobile/home'

function mapStateToProps(state) {
  return {modal: state.modal}
}

export default connect(mapStateToProps)(Home)