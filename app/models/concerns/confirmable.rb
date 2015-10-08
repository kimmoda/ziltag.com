module Confirmable
  extend ActiveSupport::Concern
  class_methods do
    def confirmed owner=nil
      where_state = 'users.confirmed_at IS NOT NULL'
      where_state << ' OR users.id = ?' if owner
      joins(:user).where(where_state, owner)
    end
  end
end