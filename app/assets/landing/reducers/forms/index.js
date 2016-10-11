export function forgotPassword(state, action) {
  switch (action.type) {
    case 'FAIL_FORGOT_PASSWORD':
      return {...state, _error: action.error}
    default:
      return state
  }
}

export function signIn(state, action){
  switch (action.type) {
    case 'FAIL_SIGN_IN':
      return {...state, _error: action.error}
    default:
      return state
  }
}

export function signUp(state, action){
  switch (action.type) {
    case 'FAIL_SIGN_UP':
      return {...state, _error: action.error}
    default:
      return state
  }
}
