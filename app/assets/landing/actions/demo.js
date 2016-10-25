export function openDemo(url){
  return {
    type: 'OPEN_DEMO',
    url
  }
}

export function closeDemo(){
  return {
    type: 'CLOSE_DEMO'
  }
}

export function hoverIn(){
  return {
    type: 'DEMO_HOVER_IN'
  }
}
export function hoverOut(){
  return {
    type: 'DEMO_HOVER_OUT'
  }
}
export function readerOpened(){
  return {
    type: 'DEMO_READER_OPENED'
  }
}
export function readerClosed(){
  return {
    type: 'DEMO_READER_CLOSED'
  }
}
