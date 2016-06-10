class Product < ApplicationRecord
  belongs_to :contest
  belongs_to :school

  has_many :documents
end
