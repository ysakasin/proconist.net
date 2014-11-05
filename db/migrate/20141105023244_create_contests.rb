class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.string :name, :null => false
      t.string :date, :null => false
      t.string :place, :null => false
      t.string :competition_title, :null => false
      t.string :themed_title, :null => false
    end
  end
end
