import {connect} from 'react-redux'
import DemoGreeting from '../../components/modals/DemoGreeting'
import {bindActionCreators} from 'redux'
import {closeModal} from '../../actions'

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(DemoGreeting)

function mapStateToProps(state) {
  const {name, url} = state.demo
  return {name, url}
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({
    onStart: closeModal
  }, dispatch)
}
