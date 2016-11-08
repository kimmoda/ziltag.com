export function requestShortenURL(url){
  return {
    type: 'REQUEST_SHORTEN_URL', url
  }
}

export function receiveShortenURL(id, url){
  return {
    type: 'RECEIVE_SHORTEN_URL', id, url
  }
}
