export function signIn(state, action){
  switch (action.type) {
    case 'FAIL_SIGN_IN':
      return {...state, _error: action.error}
    default:
      return state
  }
}
