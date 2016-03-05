function modal(state, action) {
  switch (action.type) {
    case 'WATCH_VIDEO':
      return 'VIDEO'
      break
    case 'CLICK_JOIN':
      return 'JOIN'
      break
    case 'REGISTER':
      return 'THANK_YOU'
      break
    case 'CLOSE':
      return undefined
    default:
      return state
  }
}

function platform(state='general', action){
  return action.type == 'SELECT_PLATFORM' ? action.platform : state
}

function error(state, action) {
  switch (action.type) {
    case 'SHOW_ERROR':
      return action.message
      break
    case 'CLOSE':
      return undefined
      break
    default:
      return state
  }
}

export default function homeReducers(state = {}, action) {
  return {
    modal: modal(state.modal, action),
    platform: platform(state.platform, action),
    error: error(state.error, action)
  }
}