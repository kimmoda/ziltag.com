import Tracker from '../tracker'
import ZeroClipboard from 'zeroclipboard'
import swfPath from 'zeroclipboard/dist/ZeroClipboard.swf'

var btn = document.getElementById('copy-button')
if (btn != undefined) {
  ZeroClipboard.config({
    swfPath: swfPath
  })
  var client = new ZeroClipboard(document.getElementById('copy-button'))
  client.on('aftercopy', function(event) {
    Tracker.record('click-copy')
  })
}