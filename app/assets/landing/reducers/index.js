export {routerReducer as routing} from 'react-router-redux'
export * from './modal'

import * as forms from './forms'
import {reducer as formReducer} from 'redux-form'
export const form = formReducer.plugin(forms)
