import * as schema from '../schema'

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

export function graphql(query, variables = null) {
  return api('/api/v2/graphql', {params: {query, variables}})
}

export function verify(password, password_confirmation, confirmation_token) {
  return api('/api/v2/verify', {params: {password, password_confirmation, confirmation_token}})
}

export function sign_out() {
  return api('/api/v2/sign_out', {method: 'GET'})
}

export function fetchMe() {
  return graphql('{me{ziltagNotification,commentNotification,id,avatar,isPartner,confirmed,email,name,website{id,restricted,token,url,platform},websites{id,restricted,token,url,ziltags{id,usr{id,name}},comments{id,usr{id,name}},maps_without_tags{id,src}}}}')
}

export function fetchRecommendedZiltagMaps(){
  return graphql('{recommended_ziltag_maps{id,src,host,href,website{id,restricted,url,user{id,avatar,name}},ziltags{id,x,y}}}')
}

export function changePassword(oldPassword, newPassword, confirmPassword){
  return graphql(`
    mutation updateUser($oldPassword: String!, $newPassword: String!, $confirmPassword: String!){
      updateUser(
        old_password: $oldPassword,
        new_password: $newPassword,
        confirm_password: $confirmPassword
      ){name}
    }
  `, {oldPassword, newPassword, confirmPassword})
}

export function createWebsite(url) {
  return graphql(`
    mutation createWebsite($url: String!){
      createWebsite(url: $url){
        user{id websites{id restricted url token ziltags{id} comments{id} maps_without_tags{id}}}
      }
    }
  `, {url})
}

export function deleteWebsite(id) {
  return graphql(`
    mutation deleteWebsite($id: ID!){
      deleteWebsite(id: $id){
        id
      }
    }
  `, {id})
}

export function updateWebsite(id, url) {
  return graphql(`
    mutation updateWebsite($id: ID!, $url: String!){
      updateWebsite(id: $id, url: $url){
        id,url
      }
    }
  `, {id, url})
}

export function signIn(username, password) {
  return api('/api/v2/sign_in', {params: {sign_in: username, password}} )
}

export function partnerSignUp(username, email, url) {
  return graphql(`
    mutation createPartner($username: String!, $email: String!, $url: String!){
      createPartner(username: $username, email: $email, url: $url){
        id
      }
    }
  `, {username, email, url})
}

export function uploadAvatar(file) {
  const data = new FormData()
  data.append('file', file)
  data.append('query', 'mutation uploadAvatar{uploadAvatar{id,avatar}}')
  return api('/api/v2/graphql', {
    headers: {
      'Accept': 'application/json'
    },
    body: data
  })
}

export function upgradeUser(url) {
  return graphql(`
    mutation upgradeUser($url: String!){
      upgradeUser(url: $url){
        id
      }
    }
  `, {url})
}

export function updateWebsitePermission(id, restricted) {
  return graphql(`
    mutation updateWebsitePermission($id: ID!, $restricted: Boolean!){
      updateWebsitePermission(id: $id, restricted: $restricted){
        id,restricted
      }
    }
  `, {id, restricted})
}

export function updateZiltagNotification(ziltagNotification){
  return graphql(`
    mutation updateZiltagNotification($ziltagNotification: Boolean!){
      updateZiltagNotification(ziltagNotification: $ziltagNotification){
        id
      }
    }
  `, {ziltagNotification})
}

export function updateCommentNotification(commentNotification){
  return graphql(`
    mutation updateCommentNotification($commentNotification: Boolean!){
      updateCommentNotification(commentNotification: $commentNotification){
        id
      }
    }
  `, {commentNotification})
}

export function resetPassword(password, passwordConfirmation, resetPasswordToken){
  return api(
    '/api/v2/reset_password',
    {
      method: 'PUT',
      params: {
        password,
        password_confirmation: passwordConfirmation,
        reset_password_token: resetPasswordToken
      }
    }
  )
}

export function forgetPassword(email){
  return api('/api/v2/password', {params: {email}})
}
