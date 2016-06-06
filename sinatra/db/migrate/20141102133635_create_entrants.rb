class CreateEntrants < ActiveRecord::Migration
  def change
    create_table :entrants do |t|
      t.integer :contest, :null => false
      t.integer :section, :null => false
      t.integer :registry_num, :null => false
      t.string  :school, :null => false
      t.string  :production, :null => false
      t.string  :github
      t.string  :bitbucket
      t.string  :other_repo
      t.string  :slideshare
      t.string  :other_slide
      t.string  :twitter
      t.string  :facebook
      t.string  :site
      t.integer :result
      t.string  :prize
    end
  end
end
