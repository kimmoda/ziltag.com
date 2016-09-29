export function requestSignUp(username, email, url){
  return {
    type: 'REQUEST_SIGN_UP',
    username, email, url
  }
}

export function failSignUp(error){
  return {
    type: 'FAIL_SIGN_UP',
    error
  }
}
