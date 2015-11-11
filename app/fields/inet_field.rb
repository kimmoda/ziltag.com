require "administrate/fields/base"

class InetField < Administrate::Field::String
  def self.searchable?
    false
  end

  def to_s
    data
  end
end