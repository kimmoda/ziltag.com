import React from 'react'

if(typeof window !== 'undefined') require('./index.css')

export default () => (
  <div className="p-home">
    <div className="p-home__cover"></div>
    <div className="p-home__usage"></div>
    <div className="p-home__get-start"></div>
    <div className="p-home__footer"></div>
  </div>
)
