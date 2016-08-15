# frozen_string_literal: true
require 'administrate/field/string'

class InetField < Administrate::Field::String
  def self.searchable?
    false
  end

  def to_s
    data
  end
end
