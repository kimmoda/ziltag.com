import Tracker from '../tracker'
import ZeroClipboard from 'zeroclipboard'
import 'zeroclipboard/dist/ZeroClipboard.swf'

var btn = document.getElementById('copy-button')
if (btn != undefined) {
  var client = new ZeroClipboard(document.getElementById('copy-button'))
  client.on('aftercopy', function(event) {
    Tracker.record('click-copy')
  })
}
