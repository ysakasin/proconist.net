class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.integer :contest_id,    null: false
      t.integer :section,       null: false
      t.string  :product_name,  null: false
      t.string  :email,         null: false
      t.string  :repository_url
      t.string  :slide_url
      t.string  :site_url
      t.string  :twitter
      t.string  :facebook
      t.string  :comment

      t.timestamps
    end
  end
end
