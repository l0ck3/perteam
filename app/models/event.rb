class Event < ApplicationRecord
  has_many :teams, dependent: :destroy
end
