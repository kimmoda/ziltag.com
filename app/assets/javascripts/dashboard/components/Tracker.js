import React from 'react'

export default props => (
  <div onClick={()=>handleClick(props.event)}>{props.children}</div>
)

function handleClick(event){
  const formData = new FormData()
  formData.append('event', event)
  fetch('/api/v1/track', {
    method: 'POST',
    body: formData,
    credentials: 'same-origin'
  })
}
