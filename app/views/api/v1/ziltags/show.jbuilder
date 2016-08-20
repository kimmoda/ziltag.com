# frozen_string_literal: true
json.id @ziltag.natural_id
json.map_id @ziltag.photo.natural_id
json.content @ziltag.content
json.created_at @ziltag.created_at
json.usr @ziltag.user, partial: 'user', as: :user
json.comments @ziltag.comments.includes(:user).confirmed(current_user), partial: 'comment', as: :comment
