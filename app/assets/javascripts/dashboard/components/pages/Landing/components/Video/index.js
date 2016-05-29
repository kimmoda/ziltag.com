import React from 'react'
import YouTube from 'react-youtube'
import Button from '../../../../Button'
import './index.scss'

const buttonStyle = {
  height: 77,
  borderRadius: 91
}

export default class  extends React.Component {
  render () {
    const {id, layer, watch, resume, replay, join, onWatch, onResume, onJoin, onReplay, onPause, onEnd, playerVars} = this.props
    return (
      <div className="ziltag-landing-video">
        <YouTube
          videoId={id}
          className="ziltag-landing-video__iframe"
          opts={{
            width: '100%',
            height: '100%',
            allowfullscreen: true,
            playerVars: {
              rel: 0,
              controls: 0,
              showinfo: 0,
              ...playerVars
            }
          }}
          onReady={event => this.setState({instance: event.target})}
          onPause={onPause}
          onEnd={onEnd}
        />
        <div>
          {
            layer ? <div className="ziltag-landing-video__layer" /> : null
          }
        </div>
        <div className="ziltag-landing-video__content">
          {
            watch ?
            <div className="ziltag-landing-video__button">
              <Button style={{backgroundColor: 'rgba(0,0,0,.7)', ...buttonStyle}} round white onClick={_ => onWatch(this.state.instance)}>
                <div className="ziltag-landing-video__icon"></div>
                Watch video
              </Button>
            </div>
            : null
          }
          {
            resume ?
            <div className="ziltag-landing-video__button">
              <Button style={buttonStyle} round gray onClick={_ => onResume(this.state.instance)}>
                <div className="ziltag-landing-video__icon ziltag-landing-video__icon--dark"></div>
                Resume
              </Button>
            </div>
            : null
          }
          {
            replay ?
            <div className="ziltag-landing-video__button">
              <Button style={buttonStyle} round gray onClick={_=>onReplay(this.state.instance)}>
                <div className="ziltag-landing-video__icon ziltag-landing-video__icon--replay"></div>
                Replay
              </Button>
            </div>
            : null
          }
          {
            join ?
            <div className="ziltag-landing-video__button">
              <Button style={buttonStyle} round onClick={onJoin}>Join for free</Button>
            </div>
            : null
          }
        </div>
      </div>
    )
  }
}