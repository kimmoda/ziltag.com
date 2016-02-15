import '../stylesheets/application.scss'
import '../images/sticker.png'
import '../images/logo.png'
import '../images/fallback/guest.png'
import '../images/fallback/default_guest.png'
import '../images/fallback/thumb_guest.png'
import '../images/reply.png'

import 'jquery'
import 'material-design-lite'
var req = require.context("./blocks", true, /^.*$/igm)
req.keys().forEach(function(key){
    req(key)
})
import './photos/show.coffee'
import './pages/home.coffee'
import './pages/install'
import './tracker'