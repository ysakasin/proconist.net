class AddNullFalseValidationToArticleCategories < ActiveRecord::Migration[5.0]
  def change
    change_column_null :article_categories, :name, false
  end
end
