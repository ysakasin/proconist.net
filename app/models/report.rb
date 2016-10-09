class Report < ApplicationRecord
  belongs_to :contest

  validates :email, format: {
    with: /\A.+@.+\..+\z/,
    message: '不正なメールアドレスだと思われます。'
  }
  validates :product_name, presence: true
  validates :section, inclusion: { in: [0, 1, 2] }
end
