class CreatePrizes < ActiveRecord::Migration[5.0]
  def change
    create_table :prizes do |t|
      t.integer :product_id,  null: false
      t.string  :name,        null: false

      t.timestamps
    end

    add_index :prizes, [:product_id, :name], name: 'index_prizes_product_name_unique', unique: true
  end
end
