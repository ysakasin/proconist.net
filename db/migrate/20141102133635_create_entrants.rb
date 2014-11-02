class CreateEntrants < ActiveRecord::Migration
  def change
    create_table :entrantsm, :id => false do |t|
      t.integer :id
      t.string  :school, :null => false
      t.string  :production, :null => false
      t.integer :section, :null => false
      t.string  :media
      t.string  :media_urls
      t.integer :sns
      t.string  :name_in_sns
      t.string  :sns_url
      t.integer :result
      t.string  :prize
    end
  end
end
