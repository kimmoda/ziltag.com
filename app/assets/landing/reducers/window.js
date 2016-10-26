export function window(state={}, action){
  const {type, ...windowProps} = action
  switch (type) {
    case 'SET_WINDOW':
      return {...windowProps}
    default:
      return state
  }
}
