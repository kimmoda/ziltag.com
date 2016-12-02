import {LOCATION_CHANGE} from 'react-router-redux'

export function demo(state={signOutAlert: false, tip: true, url: null, step: 1, loading: true, name: null}, action) {
  const {url} = action
  switch (action.type) {
    case 'RECEIVE_SHORTEN_URL':
      return {...state, url: action.url, step: 1, loading: true}
    case 'DEMO_HOVER_IN':
      return state.step != 5 ? {...state, step: 2} : state
    case 'DEMO_HOVER_OUT':
      return state.step == 2 ? {...state, step: 1} : state
    case 'DEMO_READER_OPENED':
      return state.step != 5 ? {...state, step: 3} : state
    case 'DEMO_READER_CLOSED':
      return state.step != 5 ? {...state, step: 1} : {...state, tip: false}
    case 'DEMO_INPUT_OPENED':
      return state.step != 5 ? {...state, step: 4} : state
    case 'DEMO_ZILTAG_CREATED':
      return {...state, step: 5}
    case 'SHOW_IFRAME':
      return {...state, step: 1, loading: false}
    case 'DISABLE_TIP':
      return {...state, tip: false}
    case 'OPEN_SIGN_OUT_ALERT':
      return {...state, signOutAlert: true}
    case 'CLOSE_SIGN_OUT_ALERT':
      return {...state, signOutAlert: false}
    case LOCATION_CHANGE:
      switch (action.payload.query.ref) {
        case 'producthunt':
          return {...state, name: 'Product Hunter'}
        case 'hackernews':
          return {...state, name: 'HackerNews Friend'}
        default:
          return state
      }
    default:
      return state
  }
}
