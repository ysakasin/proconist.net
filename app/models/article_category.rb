# rubocop:disable Rails/HasAndBelongsToMany

class ArticleCategory < ApplicationRecord
  has_and_belongs_to_many :articles
end
