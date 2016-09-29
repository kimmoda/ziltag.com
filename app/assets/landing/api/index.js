function api(input, options={}) {
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

export function signIn(username, password) {
  return api('/api/v2/sign_in', {params: {sign_in: username, password}})
}
