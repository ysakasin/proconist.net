class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.integer :product_id,  null: false
      t.string  :type,        null: false
      t.string  :url,         null: false

      t.timestamps
    end
  end
end
