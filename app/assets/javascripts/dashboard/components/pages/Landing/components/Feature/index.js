import React from 'react'
import Intro from '../Intro'
import Video from '../Video'
import Usecase from '../Usecase'
import './index.scss'

export default props => (
  <div className="ziltag-landing-feature">
    <div className="ziltag-landing-feature__title">A Picture Worth a Thousand Tags</div>
    <div className="ziltag-landing-feature__subtitle">Ziltag is a visual tagging plugin that helps you discover and discuss wonderful things.<br/>It gives you the power to tag and write on anything in images.</div>
    <div className="ziltag-landing-feature__sections">
      <div style={{width: 318}} className="ziltag-landing-feature__section">
        <Intro icon="gallery" title="MULTIPLE TAGS ON ONE IMAGE" content="You can tag more than one ziltag on a single image, which offers you more freedom and flexibility to promote yourself in an efficient way. No matter you wish to introduce your product, write a restaurant review, or post a travel journal, we’re always here for you." />
      </div>
      <div style={{width: 277}} className="ziltag-landing-feature__section">
        <Intro icon="cupcake" title="DIRECT ENGAGEMENT" content="Ziltag allows you to specifically tag everything that appears in images. This direct content interaction gives your visitors instant access to the information they need, which largely enhance content engagement and user interaction." />
      </div>
      <div style={{width: 277}} className="ziltag-landing-feature__section">
        <Intro icon="clock" title="REAL TIME UPDATE" content="New ziltags and comments are displayed in real-time, without the need to refresh to acquire the updated information. Your website visitors can enjoy a smooth browsing experience and staying current with everything just happen." />
      </div>
      <div style={{width: 280}} className="ziltag-landing-feature__section">
        <Intro icon="conversation" title="INTERACTIVE IMAGES" content="Your website visitors can easily comment on your ziltag and they can even post a new ziltag to supply information or ask questions about something interesting that go unnoticed in the image." />
      </div>
      <div style={{width: 293}} className="ziltag-landing-feature__section">
        <Intro icon="thumbsup" title="SOCIAL MEDIA INTEGRATION" content="We realized that people uses multiple social media platforms, so we integrate ourselves perfectly with them. Your visitors can easily share your tag to other social media platform such as Facebook and Twitter." />
      </div>
    </div>
    <div className="ziltag-landing-feature__video">
      <Video />
    </div>
    <div className="ziltag-landing-feature__imagine-title">Imagine…</div>
    <div className="ziltag-landing-feature__imagine-subtitle">You can use it for all kinds of purposes.</div>
    <div className="ziltag-landing-feature__usecases">
      <Usecase link="http://blog.ziltag.com/post/142941430640/how-to-use-ziltag-1-mapping" icon="map" name="Mapping" />
      <Usecase link="http://blog.ziltag.com/post/143003745025/how-to-use-ziltag-2-ecommerce" icon="pie" name="E-commerce" />
      <Usecase link="http://blog.ziltag.com/post/143324183760/how-to-use-ziltag-3-education" icon="notebook" name="Education" />
    </div>
    <a className="ziltag-landing-feature__checkout-more" href="http://blog.ziltag.com/tagged/usage" target="_blank">CHECK OUT MORE ➔</a>
  </div>
)