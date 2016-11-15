export function demo(state={tip: true, url: null, step: 1, loading: true, snackbar: false}, action) {
  const {url} = action
  switch (action.type) {
    case 'RECEIVE_SHORTEN_URL':
      return {...state, url: action.url, step: 1, loading: true, snackbar: false}
    case 'DEMO_HOVER_IN':
      return {...state, step: 2}
    case 'DEMO_HOVER_OUT':
      if(state.step == 2) {
        return {...state, step: 1}
      } else return state
    case 'DEMO_READER_OPENED':
      return {...state, step: 3}
    case 'DEMO_READER_CLOSED':
      return {...state, step: 1}
    case 'DEMO_INPUT_OPENED':
      return {...state, step: 4}
    case 'DEMO_ZILTAG_CREATED':
      return {...state, step: 5}
    case 'SHOW_IFRAME':
      return {...state, tip: true, step: 1, loading: false, snackbar: true}
    case 'CLOSE_SNACKBAR':
      return {...state, snackbar: false}
    case 'DISABLE_TIP':
      return {...state, tip: false}
    default:
      return state
  }
}
