function api(input, options) {
  const body = JSON.stringify(options.params)
  return fetch(input, {
    method: 'POST',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
    credentials: 'include',
    body,
    ...options
  }).then(response => response.json())
}

export function graphql(query, variables){
  const params = { query, variables }
  return fetch('/api/v2/graphql', {
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
  return api('/api/v2/verify', {params: {password, password_confirmation, confirmation_token}})
}

export function sign_out() {
  return api('/api/v2/sign_out', {method: 'GET'})
}