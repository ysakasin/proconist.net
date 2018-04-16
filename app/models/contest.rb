class Contest < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :reports, dependent: :nullify
end
