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
