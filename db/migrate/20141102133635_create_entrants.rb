class CreateEntrants < ActiveRecord::Migration
  def change
    create_table :entrants do |t|
      t.integer :contest, :null => false
      t.integer :section, :null => false
      t.integer :registry_num, :null => false
      t.string  :school, :null => false
      t.string  :production, :null => false
      t.integer :code
      t.string  :code_url
      t.integer :slide
      t.string  :slide_url
      t.string  :site_url
      t.integer :sns
      t.string  :name_in_sns
      t.string  :sns_url
      t.integer :result
      t.string  :prize
    end
  end
end
