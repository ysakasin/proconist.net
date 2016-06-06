class CreateOperators < ActiveRecord::Migration
  def change
    create_table :operators do |t|
      t.string  :op_id, null: false
      t.integer :position, :null => false, :default => 0
      t.string  :name, :null => false
      t.string  :password_hash, :null => false
      t.string  :password_salt, :null => false
      t.string  :icon
      t.string  :school
      t.string  :github
      t.string  :bitbucket
      t.string  :slideshare
      t.string  :twitter
      t.string  :facebook
      t.string  :site
      t.string  :description
    end
    add_index :operators, :op_id, unique: true
  end
end
