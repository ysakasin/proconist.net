class AddPublishdAtColumnInArticle < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :published_at, :datetime, null: false, default: Time.zone.parse('2200-12-31')
  end
end
