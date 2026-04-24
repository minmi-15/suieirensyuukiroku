class ChangeColumnPosts < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :time, :integer, defalult: 0
    change_column :posts, :stroke, :integer, default: 0
  end
end
