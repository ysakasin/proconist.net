class CreateOperators < ActiveRecord::Migration
  def change
    create_table :operators, :id => false do |t|
      t.string  :id, :null => false
      t.integer :position, :null => false
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
      t.string  :site_name
      t.string  :site_url
      t.string  :description
    end
  end
end
