class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :label, :null => false
      t.string  :title, :null => false
      t.string  :href, :null => false
      t.string  :img
      t.timestamps
    end
  end
end
