class CreateOperators < ActiveRecord::Migration[5.0]
  def change
    create_table :operators do |t|
      t.string :identifier,                 null: false
      t.integer :position,      default: 0, null: false
      t.string :name,                       null: false
      t.string :password_digest
      t.string :icon
      t.integer :school_id
      t.string :github
      t.string :bitbucket
      t.string :slideshare
      t.string :twitter
      t.string :facebook
      t.string :site
      t.string :description
      t.string :email

      t.timestamps
    end

    add_index :operators, :identifier, unique: true
  end
end
