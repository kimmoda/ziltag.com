import * as schema from '../schema'
import Lokka from 'lokka'
import Transport from 'lokka-transport-http'

export const graphql = new Lokka({
  transport: new Transport('/api/v2/graphql')
})

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

export function verify(password, password_confirmation, confirmation_token) {
  return api('/api/v2/verify', {params: {password, password_confirmation, confirmation_token}})
}

export function sign_out() {
  return api('/api/v2/sign_out', {method: 'GET'})
}

export function fetchMe() {
  return graphql.query('{me{id,avatar,isPartner,confirmed,email,name,website{id,token,url,platform},websites{id,token,url,ziltags{id,usr{id,name}},comments{id,usr{id,name}},maps_without_tags{id,src}}}}')
}

export function fetchRecommendedZiltagMaps(){
  return graphql.query('{recommended_ziltag_maps{id,src,host,href,website{id,url,user{id,avatar,name}},ziltags{id,x,y}}}')
}