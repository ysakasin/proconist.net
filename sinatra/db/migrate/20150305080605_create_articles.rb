class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :url, null: false
      t.string :title
      t.string :body
      t.string :category
      t.string :auther
      t.string :thumbnail
      t.timestamps
    end
    add_index :articles, :url, unique: true
  end
end
