export function sendDemoLink(email, preview_id){
  return api('/api/v2/send_demo_link', {params: {email, preview_id}})
}

export function forgotPassword(email){
  return api('/api/v2/password', {params: {email}})
}

export function signIn(username, password) {
  return api('/api/v2/sign_in', {params: {sign_in: username, password}})
}

export function signUp(username, email, url) {
  return graphql(`
    mutation createPartner($username: String!, $email: String!, $url: String!){
      createPartner(username: $username, email: $email, url: $url){
        id
      }
    }
  `, {username, email, url})
}

export function createShortenURL(url) {
  return graphql(`
    mutation createShortenURL($url: String!){
      createShortenURL(url: $url){
        id, url
      }
    }
  `, {url})
}

export function verify(password, password_confirmation, confirmation_token) {
  return api('/api/v2/verify', {params: {password, password_confirmation, confirmation_token}})
}

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

function graphql(query, variables = null) {
  return api('/api/v2/graphql', {params: {query, variables}})
}
