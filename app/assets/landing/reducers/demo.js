export function demo(state={isOpen: false}, action) {
  const {url} = action
  switch (action.type) {
    case 'OPEN_DEMO':
      return {isOpen: true, url}
    case 'CLOSE_DEMO':
      return {isOpen: false}
    default:
      return state
  }
}
