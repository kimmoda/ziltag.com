import React from 'react'
import Intro from '../Intro'
import Video from '../../containers/Video'
import Usecase from '../Usecase'
import './index.scss'
import Tracker from 'Tracker'

export default props => (
  <div className="ziltag-landing-feature">
    <div className="ziltag-landing-feature__title">Turn Images into Conversation</div>
    <div className="ziltag-landing-feature__subtitle">Despite a picture is worth a thousand words, sometimes it’s just not enough. Ziltag allows you to annotate on anything over images.</div>
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
        <Tracker event="mapping">
          <Usecase link="http://blog.ziltag.com/2016/06/18/ziltag_for_mapping/" icon="map" name="Mapping" />
        </Tracker>
      </div>
      <div className="ziltag-landing-feature__usecase">
        <Tracker event="e-commerce">
          <Usecase link="http://blog.ziltag.com/2016/04/18/how-to-use-ziltag-2-ecommerce/" icon="pie" name="E-commerce" />
        </Tracker>
      </div>
      <div className="ziltag-landing-feature__usecase">
        <Tracker event="education">
          <Usecase link="http://blog.ziltag.com/2016/04/24/how-to-use-ziltag-3-education/" icon="notebook" name="Education" />
        </Tracker>
      </div>
    </div>
    <a className="ziltag-landing-feature__checkout-more" href="//blog.ziltag.com/benefits/" target="_blank">CHECK OUT MORE ➔</a>
  </div>
)
