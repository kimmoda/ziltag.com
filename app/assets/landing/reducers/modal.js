export function modal(state={}, action){
  switch (action.type) {
    case 'OPEN_MODAL':
      const {name, mode} = action
      return {name, mode}
    case 'CLOSE_MODAL':
      return {}
    default:
      return state
  }
}
