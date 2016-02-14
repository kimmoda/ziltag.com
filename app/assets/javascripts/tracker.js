var Tracker = {
  record: function(event_name) {
    fetch('/api/v1/track', {
      method: 'post',
      credentials: 'include',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        event: event_name
      })
    })
  }
}

document.addEventListener('DOMContentLoaded', function() {
  var buttons = document.querySelectorAll('[data-event]')
  for (var i = 0; i < buttons.length; i++) {
    buttons[i].addEventListener('click', function() {
      Tracker.record(this.dataset.event)
    })
  }
})

module.exports = Tracker