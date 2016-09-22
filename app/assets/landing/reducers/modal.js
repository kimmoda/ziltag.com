export function modal(state=null, action){
  switch (action.type) {
    case 'OPEN_MODAL':
      return action.name
    case 'CLOSE_MODAL':
      return null
    default:
      return state
  }
}
