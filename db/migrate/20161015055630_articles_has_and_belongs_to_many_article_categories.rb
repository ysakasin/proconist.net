class ArticlesHasAndBelongsToManyArticleCategories < ActiveRecord::Migration[5.0]
  def change
    create_join_table :articles, :article_categories do |t|
      t.index :article_id
      t.index :article_category_id
    end

    change_table :articles do |t|
      t.remove :category_id
    end
  end
end
