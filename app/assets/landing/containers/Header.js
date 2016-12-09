import Header from '../components/Header'
import {connect} from 'react-redux'
import ModalButton from '../containers/ModalButton'

export default connect(
  state => ({
    isWide: state.window.width >= 2048,
    showSignUp: !state.isSignedIn,
    showSignIn: !state.isSignedIn,
    showDashboard: state.isSignedIn,
    ModalButton: ModalButton
  })
)(Header)
