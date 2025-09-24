class AddMaxClickToUrls < ActiveRecord::Migration[8.0]
  def change
    add_column :urls, :max_click, :integer
  end
end