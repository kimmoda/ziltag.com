import React from 'react'
import ReactDOM from 'react-dom'
import { Provider } from 'react-redux'
import { createStore } from 'redux'
import HomeContainer from '../containers/mobile/home.js'
import homeReducer from '../reducers/mobile/home.js'
import 'normalize.css/normalize.css'

let store = createStore(homeReducer)

ReactDOM.render(
  <Provider store={store}>
    <HomeContainer />
  </Provider>,
  document.getElementById('home')
)