import {getStore} from './store'
import {getRoutes} from './routes'

import {Provider} from 'react-redux'
import {createElement} from 'react'
import {renderToString} from 'react-dom/server'
import {match, RouterContext} from 'react-router'

module.exports = function(path){
  var store = getStore()
  var error, redirectLocation, renderProps

  match({routes: getRoutes(), location: path}, function(_error, _redirectLocation, _renderProps){
    error = _error
    redirectLocation = _redirectLocation
    renderProps = _renderProps
  })
  var ret

  if (error) {
    return { status: 500, error: error }
  } else if (redirectLocation) {
    return {status: 302, location: redirectLocation}
  } else if (renderProps) {
    return {
      status: 200,
      body: renderToString(
        createElement(
          Provider, { store: store }, createElement(RouterContext, renderProps)
        )
      ),
      state: store.getState()
    }
  } else {
    return {
      status: 404
    }
  }
}
