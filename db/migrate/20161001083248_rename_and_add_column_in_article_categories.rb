class RenameAndAddColumnInArticleCategories < ActiveRecord::Migration[5.0]
  def change
    change_table :article_categories do |t|
      t.rename :name, :url
    end

    add_column :article_categories, :name, :string
  end
end
