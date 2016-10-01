class Article < ApplicationRecord
  belongs_to :category, class_name: :ArticleCategory
  belongs_to :operator
end
