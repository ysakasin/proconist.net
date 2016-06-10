class Product < ApplicationRecord
  belongs_to :contest
  belongs_to :school

  has_many :documents

  validates :section, inclusion: { in: [0, 1, 2] }

  SECTIONS = %w(
    competition
    themed
    original
  )

  def section_name
    SECTIONS[section]
  end

end
