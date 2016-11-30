export function requestDemoLink(email, preview_id){
  return {
    type: 'REQUEST_DEMO_LINK',
    email, preview_id
  }
}

export function showIframe(){
  return {
    type: 'SHOW_IFRAME'
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

export function inputOpened(){
  return {
    type: 'DEMO_INPUT_OPENED'
  }
}

export function ziltagCreated(){
  return {
    type: 'DEMO_ZILTAG_CREATED'
  }
}

export function disableTip() {
  return {
    type: 'DISABLE_TIP'
  }
}

export function openSignOutAlert(){
  return {
    type: 'OPEN_SIGN_OUT_ALERT'
  }
}


export function closeSignOutAlert(){
  return {
    type: 'CLOSE_SIGN_OUT_ALERT'
  }
}
