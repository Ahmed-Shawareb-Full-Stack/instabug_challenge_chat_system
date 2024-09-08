class App < ApplicationRecord
  has_secure_token

  validates :name, presence: true
end
