class AddDetailsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :stroke, :string
    add_column :posts, :time, :string
  end
end
