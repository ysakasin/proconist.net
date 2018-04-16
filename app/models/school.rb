class School < ApplicationRecord
  has_many :products, dependent: :nullify
end
