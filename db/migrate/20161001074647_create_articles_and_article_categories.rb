class CreateArticlesAndArticleCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string  :url,           null: false
      t.string  :title,         null: false
      t.text    :body,          null: false
      t.integer :category_id,   null: false
      t.integer :operator_id,   null: false
      t.string  :thumbnail_url, null: false

      t.timestamps
    end

    create_table :article_categories do |t|
      t.string :name,         null: false
      t.string :description,  null: false

      t.timestamps
    end
  end
end
