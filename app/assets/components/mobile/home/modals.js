import React from 'react'
import Modal from '../modal'
import JoinModalContainer from './join_modal_container.js'

export const ThankYou = (props) => {
  return(
    <Modal
      dismissible
      logo
      {...props}
    >
      <div className="ziltag-mobile-home__thank-you">
      <div className="ziltag-mobile-home__thank-you-title">Thank you for joining Ziltag Partner!</div>
      <div className="ziltag-mobile-home__thank-you-subtitle">Please check you email inbox to acquire your plugin script.</div>
      </div>
    </Modal>
  )
}

export const Video = (props) => {
  return(
    <Modal
      dismissible
      headerTitle="Watch Video"
      {...props}
    >
      <iframe width="100%" height="100%" src="https://www.youtube.com/embed/ic2-Ascvte4" frameborder="0" allowfullscreen></iframe>
    </Modal>
  )
}

export default class Modals extends React.Component {
  render(){
    switch (this.props.select) {
      case 'VIDEO':
        return <Video onDismiss={ this.props.onDismiss } />
        break
      case 'JOIN':
        return <JoinModalContainer onDismiss={ this.props.onDismiss } onSubmit={this.props.onSubmit} />
        break
      case 'THANK_YOU':
        return <ThankYou onDismiss={ this.props.onDismiss } />
        break
      default:
        return null
    }
  }
}