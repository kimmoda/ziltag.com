import React from 'react'

// components
import Button from '../button'
import Intro from '../intro'
import ColorBoard from '../color_board'
import Modals from './modals.js'

// assets
import './index.scss'
import bowlPath from './bowl.jpg'
import foodsPath from './foods.jpg'
import bgPath from './bg.jpg'

export default class Home extends React.Component {

  handleSubmit(event){
    event.preventDefault()
    let formData = new FormData(event.target)
    formData.append('authenticity_token', document.querySelector('meta[name=csrf-token]').content)
    fetch('/m/register', {
      method: 'post',
      body: formData,
      credentials: 'same-origin'
    })
      .then((response) => {return response.json()})
      .then((json) => {
        if(json.error) {
          this.props.dispatch({type: 'SHOW_ERROR', message: json.error})
        }else{
          this.props.dispatch({type: 'REGISTER'})
        }
      })
  }

  render() {
    let blurStyle = this.props.modal ? {
      filter: 'blur(5px) brightness(.5)',
      WebkitFilter: 'blur(5px) brightness(.5)'
    } : {}
    return(
      <div className="ziltag-mobile-home">
        <Modals
          select={this.props.modal}
          onDismiss={ () => this.props.dispatch({type: 'CLOSE'}) }
          onSubmit={this.handleSubmit.bind(this)}
        />
        <div className="ziltag-mobile-modal-blur" style={blurStyle} onClick={ this.props.modal ? ()=>this.props.dispatch({type: 'CLOSE'}) : null } >
          <div className="ziltag-mobile-home__header" />
          <div className="ziltag-mobile-home__landing">
            <ColorBoard color="rgba(0,0,0,.54)" image={bgPath}>
              <div className="ziltag-mobile-home__title-wraper">
                <div className="ziltag-mobile-home__title">The ultimate plugin built for your images.</div>
                <div className="ziltag-mobile-home__subtitle">Connecting readers with every little details on images, we bring contents on your website alive.</div>
              </div>
              <div className="ziltag-mobile-home__join-button">
                <Button name="JOIN FOR FREE" onClick={ ()=>this.props.dispatch({type: 'CLICK_JOIN'}) } />
              </div>
              <div className="ziltag-mobile-home__watch-video" onClick={ ()=>this.props.dispatch({type: 'WATCH_VIDEO'}) }>WATCH VIDEO</div>
            </ColorBoard>
          </div>
          <div className="ziltag-mobile-home__quote">
            <div className="ziltag-mobile-home__quote-text">
              Ziltag is a visual tagging plugin that helps you discover and discuss wonderful things.
            </div>
          </div>
          <div className="ziltag-mobile-home__intros">
            <Intro icon="cupcake" title="Direct Content Engagement" content="Ziltag allows you to specifically tag everything that appears in the images. This direct content interaction gives your visitors instant access to the information they need, which largely enhance content engagement." />
            <Intro icon="gallery" title="Multiple Ziltags on one image" content="You can tag more than one Ziltag on a single image, which offers you more freedom and flexibility to promote yourself in an efficient way. No matter you wish to introduce your product, write a restaurant review, or post a travel journal, Ziltag is always here for you." />
            <Intro icon="clock" title="Real Time" content="New Ziltags and comments from everyone are displayed in real-time, without the need to refresh. Your website visitors can enjoy a smooth browsing experience and staying current with everything happens now." />
            <Intro icon="conversation" title="Interaction" content="Your website visitors can easily comment on your Ziltag and they can even post a new Ziltag on your image to supply information or ask questions about something interesting that go unnoticed in the image." />
            <Intro icon="thumbsup" title="Integration with Social Media" content="We realized that people uses multiple social media platforms, so we integrate ourselves perfectly with them. Your visitors can easily share your tag to other social media platform such as Facebook and Twitter." />
          </div>
          <div className="ziltag-mobile-home__color-board">
            <ColorBoard color="rgba(238,46,36,.77)" image={bowlPath}>
              <div className="ziltag-mobile-home__color-title">BECOME ZILTAG PARTNER EMPOWER YOUR IMAGES</div>
              <div className="ziltag-mobile-home__color-subtitle">Ziltag Partner is user who install Ziltag Plugin on his/ her website. It is free to join and easy to install.</div>
              <div className="ziltag-mobile-home__color-button">
                <Button name="JOIN US" onClick={ ()=>this.props.dispatch({type: 'CLICK_JOIN'}) } />
              </div>
            </ColorBoard>
          </div>
          <div className="ziltag-mobile-home__quote">
            <div className="ziltag-mobile-home__quote-text">
              Tag anything in the image with our most intuitive plugin.
            </div>
          </div>
          <div className="ziltag-mobile-home__color-board">
            <ColorBoard color="rgba(0,0,0,.68)" image={foodsPath}>
              <div className="ziltag-mobile-home__color-title">HEAR WHAT USERS ARE SAYING ABOUT US</div>
              <div className="ziltag-mobile-home__color-quote">“Our favorite part of Ziltag is that it helps us to present recipe, video, and product information in just one photo.”</div>
              <div className="ziltag-mobile-home__color-name">—Vivian Chou, Co Founder</div>
              <div className="ziltag-mobile-home__color-button">
                <a className="ziltag-mobile-button ziltag-mobile-button--dark" href ="http://flamboinc.tumblr.com/">VISIT WEB</a>
              </div>
            </ColorBoard>
          </div>
          <div className="ziltag-mobile-home__footer">
            <ul className="ziltag-mobile-home__footer-links">
              <li className="ziltag-mobile-home__footer-link"><a href="http://blog.ziltag.com/tagged/about">ABOUT</a></li>
              <li className="ziltag-mobile-home__footer-link"><a href="http://blog.ziltag.com">BLOG</a></li>
              <li className="ziltag-mobile-home__footer-link"><a href="http://blog.ziltag.com/post/136853735385/terms-of-service">TERMS</a></li>
              <li className="ziltag-mobile-home__footer-link"><a href="http://blog.ziltag.com/tagged/policy">PRIVACY</a></li>
            </ul>
            <ul className="ziltag-mobile-home__footer-icons">
              <li><a href="https://www.facebook.com/ziltag" className="ziltag-mobile-home__footer-icon ziltag-mobile-home__footer-icon--facebook"></a></li>
              <li><a href="http://blog.ziltag.com" className="ziltag-mobile-home__footer-icon ziltag-mobile-home__footer-icon--tumblr"></a></li>
              <li><a href="https://twitter.com/myziltag" className="ziltag-mobile-home__footer-icon ziltag-mobile-home__footer-icon--twitter"></a></li>
            </ul>
            <div className="ziltag-mobile-home__footer-copyright">© Ziltag Inc., 2016. All Rights Reserved. </div>
          </div>
        </div>
      </div>
    )
  }
}