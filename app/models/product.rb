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

  SECTIONS_ENUM = {
    '競技部門': 0,
    '課題部門': 1,
    '自由部門': 2
  }.freeze

  def section_name
    SECTIONS[section]
  end

end
