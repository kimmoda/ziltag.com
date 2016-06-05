import React from 'react'
import Slider from 'react-slick'
import ZiltagMapTile from '../../../../ZiltagMapTile'
import LeftArrow from 'material-ui/svg-icons/navigation/chevron-left'
import RightArrow from 'material-ui/svg-icons/navigation/chevron-right'
import './index.scss'

const settings = {
  infinite: true,
  dots: true,
  className: 'ziltag-slider',
  dotsClass: 'slick-dots ziltag-slider__dots'
}

const ziltagMaps = [
  {
    imageURL: 'https://ziltag.s3.amazonaws.com/uploads/photos/image/1896/default_tumblr_o6i3nqSE4i1tpy9oco1_1280.jpg',
    ziltags: [
      { id: 'd00887', x: 0.472817133443163, y: 0.292879370309354 },
    ]
  },
  {
    imageURL: 'https://ziltag.s3.amazonaws.com/uploads/photos/image/1638/default_tumblr_inline_o5rrodt9qv1tg5azs_1280.jpg',
    ziltags: [
      { id: '8651d8', x: 0.171334431630972, y: 0.404606021288764},
      { id: '54f655', x: 0.884678747940692, y: 0.253518962706251},
      { id: '265257', x: 0.514003294892916, y: 0.314978105180494},
      { id: 'b0833e', x: 0.113673805601318, y: 0.0563375472680558},
      { id: 'e05b15', x: 0.71993410214168, y: 0.665807376804295 }
    ]
  },
  {
    imageURL: 'https://ziltag.s3.amazonaws.com/uploads/photos/image/1872/default_tumblr_inline_o658dm7g5P1tg5azs_1280.jpg',
    ziltags: [
      {id: 'ba1d78', x: 0.180150125104254, y: 0.261217681401168},
      {id: '0a19b6', x: 0.322899505766063, y: 0.73838550247117},
      {id: '405ae4', x: 0.807339449541284, y: 0.522435362802335}
    ]
  }
]

export default props => {
  const {sliderHeight, onClickZiltag} = props
  const style = {
    height: sliderHeight
  }
  return (
    <Slider {...settings}>
      {
        ziltagMaps.map(ziltagMap => (
          <div key={ziltagMap.imageURL} style={style}>
            <ZiltagMapTile
              imageURL={ziltagMap.imageURL}
              ziltags={ziltagMap.ziltags}
              footer={false}
              onClickZiltag={onClickZiltag}
            />
          </div>
        ))
      }
    </Slider>
  )
}