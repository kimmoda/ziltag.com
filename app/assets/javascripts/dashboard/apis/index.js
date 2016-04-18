function api(input, params) {
  return fetch(input, {
    method: 'POST',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
    credentials: 'include',
    body: JSON.stringify(params)
  }).then(response => response.json())
}

export function verify(password, password_confirmation, confirmation_token) {
  return api('/api/v2/verify', {password, password_confirmation, confirmation_token})
}