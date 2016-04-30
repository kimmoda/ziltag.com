import Modal from '../Modal'
import * as actionTypes from '../../actions/types'

import React, { PropTypes } from 'react'
import {connect} from 'react-redux'

class IframeModal extends React.Component {
  static propsTypes = {
    src: PropTypes.string.isRequired
  }

  render () {
    const { src, ...props} = this.props
    return (
      <Modal {...props}>
        <iframe width="100%" height="100%" src={src} style={{border: 'none'}}></iframe>
      </Modal>
    )
  }
}

function mapStateToProps(state) {
  return {
    src: state.modal.src,
    isActive: state.modal.isActive
  }
}

function mapDispatchToProps(dispatch) {
  return {
    onClickOverlay: () => {dispatch({type: actionTypes.CLOSE_MODAL})}
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(IframeModal)