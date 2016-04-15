import {routerReducer} from 'react-router-redux'

export default (state = {}, action) => {
  return {routing: routerReducer(state.routing, action)}
}