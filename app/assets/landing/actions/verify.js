export function requestVerify(password, password_confirmation, confirmation_token){
  return {
    type: 'REQUEST_VERIFY',
    password, password_confirmation, confirmation_token
  }
}

export function failVerify(error){
  return {
    type: 'FAIL_VERIFY',
    error
  }
}
