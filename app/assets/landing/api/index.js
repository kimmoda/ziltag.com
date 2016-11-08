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

export function findOrCreateShortenURL(url) {
  return graphql(`
    mutation findOrCreateShortenURL($url: String!){
      findOrCreateShortenURL(url: $url){
        id, url
      }
    }
  `, {url})
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
