export function requestSignIn(username, password){
  return {
    type: 'REQUEST_SIGN_IN',
    username, password
  }
}

export function failSignIn(error){
  return {
    type: 'FAIL_SIGN_IN',
    error
  }
}
