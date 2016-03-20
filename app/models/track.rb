class Track < ActiveRecord::Base
  # scopes
  scope :stats_of_this_week, -> { where('created_at >= ?', 1.week.ago).group('date(created_at)', :event).count }

  # constants

  # attributes

  # associations

  # validations

  # callbacks

  # other
end
