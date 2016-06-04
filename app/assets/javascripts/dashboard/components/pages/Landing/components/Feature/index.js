import React from 'react'
import Intro from '../Intro'
import Video from '../../containers/Video'
import Usecase from '../Usecase'
import './index.scss'

export default props => (
  <div className="ziltag-landing-feature">
    <div className="ziltag-landing-feature__title">A Picture Worth a Thousand Tags</div>
    <div className="ziltag-landing-feature__subtitle">Ziltag is a visual tagging plugin that helps you discover and discuss wonderful things.<br/>It gives you the power to tag and write on anything in images.</div>
    <div className="ziltag-landing-feature__sections">
      <div className="ziltag-landing-feature__section">
        <Intro icon="gallery" title="Intuitive" content="Click tags to read. Click anywhere to post. No learning needed." />
      </div>
      <div className="ziltag-landing-feature__section">
        <Intro icon="cupcake" title="Simple" content="Join. Install. Enjoy. As simple as that." />
      </div>
      <div className="ziltag-landing-feature__section">
        <Intro icon="conversation" title="Interactive" content="Visitors can engage and comment. Everything in images is worth exploring." />
      </div>
      <div className="ziltag-landing-feature__section">
        <Intro icon="clock" title="Real Time" content="Smooth and fast real-time experience. No need to refresh." />
      </div>
      <div className="ziltag-landing-feature__section">
        <Intro icon="thumbsup" title="Social Media" content="Easily share interesting contents to your favourite social media." />
      </div>
    </div>
    <div className="ziltag-landing-feature__video">
      <Video id="ic2-Ascvte4"/>
    </div>
    <div className="ziltag-landing-feature__imagine-title">Imagine…</div>
    <div className="ziltag-landing-feature__imagine-subtitle">You can use it for all kinds of purposes.</div>
    <div className="ziltag-landing-feature__usecases">
      <div className="ziltag-landing-feature__usecase">
        <Usecase link="http://blog.ziltag.com/post/142941430640/how-to-use-ziltag-1-mapping" icon="map" name="Mapping" />
      </div>
      <div className="ziltag-landing-feature__usecase">
        <Usecase link="http://blog.ziltag.com/post/143003745025/how-to-use-ziltag-2-ecommerce" icon="pie" name="E-commerce" />
      </div>
      <div className="ziltag-landing-feature__usecase">
        <Usecase link="http://blog.ziltag.com/post/143324183760/how-to-use-ziltag-3-education" icon="notebook" name="Education" />
      </div>
    </div>
    <a className="ziltag-landing-feature__checkout-more" href="http://blog.ziltag.com/tagged/usage" target="_blank">CHECK OUT MORE ➔</a>
  </div>
)