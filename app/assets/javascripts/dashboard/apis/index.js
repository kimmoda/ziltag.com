import * as schema from '../schema'

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
  return graphql('{me{id,avatar,isPartner,confirmed,email,name,website{id,token,url,platform},websites{id,token,url,ziltags{id,usr{id,name}},comments{id,usr{id,name}},maps_without_tags{id,src}}}}')
}

export function fetchRecommendedZiltagMaps(){
  return graphql('{recommended_ziltag_maps{id,src,host,href,website{id,url,user{id,avatar,name}},ziltags{id,x,y}}}')
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
        user{id websites{id url token ziltags{id} comments{id} maps_without_tags{id}}}
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

export function updateWebsite(id) {
  return graphql(`
    mutation updateWebsite($id: ID!){
      updateWebsite(id: $id){
        url
      }
    }
  `, {id})
}