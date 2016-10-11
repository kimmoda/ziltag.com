export function requestForgotPassword(email){
  return {
    type: 'REQUEST_FORGOT_PASSWORD',
    email
  }
}

export function failForgotPassword(error){
  return {
    type: 'FAIL_FORGOT_PASSWORD',
    error
  }
}
