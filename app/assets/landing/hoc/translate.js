import {connect} from 'react-redux'
import React from 'react'
import i18n from 'i18n'

export default Component => connect(
  state => ({
    t: (...args) => i18n.t(...args, {lng: state.lang})
  })
)(Component)
