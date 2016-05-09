import { Schema, arrayOf } from 'normalizr'
export const user = new Schema('users')
export const ziltag = new Schema('ziltags')
export const ziltagMap = new Schema('ziltagMaps')
export const comment = new Schema('comments')
export const website = new Schema('websites')

user.define({
  ziltags: arrayOf(ziltag),
  comments: arrayOf(comment),
  websites: arrayOf(website),
  website
})

ziltag.define({
  user,
  comments: arrayOf(comment)
})

ziltagMap.define({
  ziltags: arrayOf(ziltag),
  website
})

comment.define({
  user
})

website.define({
  user,
  comments: arrayOf(website),
  ziltags: arrayOf(ziltag),
  maps_without_tags: arrayOf(ziltagMap)
})