class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :url, null: false
      t.string :name
      t.string :description
      t.string :entries
    end
    add_index :categories, :url, unique: true
  end
end
