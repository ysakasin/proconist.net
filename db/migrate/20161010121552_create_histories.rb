class CreateHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :histories do |t|
      t.integer :label, null: false
      t.string :title,  null: false
      t.string :url,    null: false
      t.string :image_path

      t.timestamps
    end
  end
end
