export function demo(state={isOpen: false, loading: true, snackbar: false}, action) {
  const {url} = action
  switch (action.type) {
    case 'OPEN_DEMO':
      return {isOpen: true, url, tip: 'hover_on_an_image', loading: true, snackbar: false}
    case 'CLOSE_DEMO':
      return {isOpen: false}
    case 'DEMO_HOVER_IN':
      return {...state, tip: 'click_the_z_button'}
    case 'DEMO_HOVER_OUT':
      return {...state, tip: 'hover_on_an_image'}
    case 'DEMO_READER_OPENED':
      return {...state, tip: 'click_anywhere'}
    case 'DEMO_READER_CLOSED':
      return {...state, tip: 'hover_on_an_image'}
    case 'SHOW_IFRAME':
      return {...state, loading: false, snackbar: true}
    case 'CLOSE_SNACKBAR':
      return {...state, snackbar: false}
    default:
      return state
  }
}
