run_in 'users', 'show', ->
  document.getElementById('cover_link').addEventListener 'click', (e) ->
    e.preventDefault()
    cover_file = document.getElementById 'user_cover'
    cover_form = document.getElementById 'cover_form'
    banner = document.getElementById 'banner'
    cover_file.addEventListener 'change', ->
      reader = new FileReader()
      reader.addEventListener 'load', (e) -> banner.src = e.target.result
      fetch '/users', {
        method: 'put'
        credentials: 'same-origin'
        body: new FormData(cover_form)
      }
      reader.readAsDataURL(@files[0])
    cover_file.click()

  document.getElementById('avatar_link').addEventListener 'click', (e) ->
    e.preventDefault()
    avatar_file = document.getElementById 'avatar_file'
    avatar_form = document.getElementById 'avatar_form'
    avatar = document.getElementById 'avatar'
    console.log avatar_file, avatar_form, avatar
    avatar_file.addEventListener 'change', ->
      reader = new FileReader()
      reader.addEventListener 'load', (e) -> avatar.src = e.target.result
      fetch '/users', {
        method: 'put'
        credentials: 'same-origin'
        body: new FormData(avatar_form)
      }
      reader.readAsDataURL(@files[0])
    avatar_file.click()