class CreateContests < ActiveRecord::Migration[5.0]
  def change
    create_table :contests do |t|
      t.string :name,               null: false
      t.string :date,               null: false
      t.string :place,              null: false
      t.string :title,              null: false
      t.string :competition_title,  null: false
      t.string :themed_title,       null: false

      t.timestamps
    end
  end
end
