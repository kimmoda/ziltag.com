import {connect} from 'react-redux'
import React from 'react'
import i18n from 'i18n'

export default Component => connect(
  state => ({
    t: (key, options) => i18n.t(key, {...options, lng: state.lang})
  })
)(Component)
