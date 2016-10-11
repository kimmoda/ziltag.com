export function modal(state={}, action){
  switch (action.type) {
    case 'OPEN_MODAL':
      const {type, name, ...payload} = action
      return {name, ...payload}
    case 'CLOSE_MODAL':
      return {}
    default:
      return state
  }
}
