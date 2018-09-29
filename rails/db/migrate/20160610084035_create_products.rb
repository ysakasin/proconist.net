class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.integer :contest_id,  null: false
      t.integer :section,     null: false
      t.integer :school_id,   null: false
      t.string  :name,        null: false
      t.integer :rank

      t.timestamps
    end
  end
end
