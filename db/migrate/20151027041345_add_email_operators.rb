class AddEmailOperators < ActiveRecord::Migration
  def change
    change_table :operators do |t|
      t.string :email
    end
  end
end
