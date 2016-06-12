class AddNthToContest < ActiveRecord::Migration[5.0]
  def change
    add_column :contests, :nth, :integer
  end
end
