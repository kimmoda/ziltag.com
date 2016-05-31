import React from 'react'
import Slider from 'react-slick'
import ZiltagMapTile from '../../../../ZiltagMapTile'

const settings = {
  infinite: true
}

const ziltagMaps = [
  {
    imageURL: 'https://ziltag.s3.amazonaws.com/uploads/photos/image/1916/default_tumblr_inline_o6n53iJ7yE1tg5azs_1280.png',
    ziltags: [
      { id: 'f574ba', x: 0.138157894736842, y: 0.834473684210526 },
      { id: '2127d5', x: 0.866776315789474, y: 0.381315789473684 },
      { id: '24e52b', x: 0.626644736842105, y: 0.381315789473684 }
    ]
  },
  {
    imageURL: 'https://ziltag.s3.amazonaws.com/uploads/photos/image/1872/default_tumblr_inline_o658dm7g5P1tg5azs_1280.jpg',
    ziltags: [
      { id: 'ba1d78', x: 0.180150125104254, y: 0.261217681401168 },
      { id: '0a19b6', x: 0.322899505766063, y: 0.73838550247117 },
      { id: '405ae4', x: 0.807339449541284, y: 0.522435362802335 }
    ]
  },
  {
    imageURL: 'https://ziltag.s3.amazonaws.com/uploads/photos/image/1633/default_tumblr_inline_o5rrnsDit31tg5azs_1280.jpg',
    ziltags: [
      { id: 'b870a7', x: 0.240527182866557, y: 0.437257907080486 },
      { id: '31aac5', x: 0.453047775947282, y: 0.492908913436185 },
      { id: '647978', x: 0.797364085667216, y: 0.408107379941787 }
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