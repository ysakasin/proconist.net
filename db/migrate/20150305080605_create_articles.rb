class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :body
      t.string :category
      t.string :auther
      t.string :thumbnail
      t.string :url
      t.timestamps
    end
  end
end
