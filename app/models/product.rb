class Product < ApplicationRecord
  belongs_to :contest
  belongs_to :school

  has_many :documents
  has_many :prizes

  validates :section, inclusion: { in: [0, 1, 2] }

  scope :competitions,  -> { where(section: 0) }
  scope :themes,        -> { where(section: 1) }
  scope :originals,     -> { where(section: 2) }

  SECTIONS = %w(
    competition
    themed
    original
  ).freeze

  def section_name
    SECTIONS[section]
  end

end
