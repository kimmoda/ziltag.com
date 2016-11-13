export function demo(state={url: null, step: 1, loading: true, snackbar: false}, action) {
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
    case 'SHOW_IFRAME':
      return {...state, step: 1, loading: false, snackbar: true}
    case 'CLOSE_SNACKBAR':
      return {...state, snackbar: false}
    default:
      return state
  }
}
