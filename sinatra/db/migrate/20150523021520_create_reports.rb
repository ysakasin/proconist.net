class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :contest, :null => false
      t.integer :section, :null => false
      t.string  :product, :null => false
      t.string  :email, :null => false
      t.string  :repository
      t.string  :slide
      t.string  :site
      t.string  :twitter
      t.string  :facebook
      t.string  :comment
      t.timestamps
    end
  end
end
