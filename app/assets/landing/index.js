import {getStore} from './store'
import {getRoutes} from './routes'

import React from 'react'
import {render} from 'react-dom'
import {Provider} from 'react-redux'
import {syncHistoryWithStore} from 'react-router-redux'
import {browserHistory} from 'react-router'
import saga, {sagaMiddleware} from './saga'

import 'normalize.css/normalize.css'
import './global.css'

const store = getStore(window.__PRELOADED_STATE__)
const history = syncHistoryWithStore(browserHistory, store)
const routes = getRoutes(history)

render(<Provider store={store}>{routes}</Provider>, document.getElementById('app'))
sagaMiddleware.run(saga)
