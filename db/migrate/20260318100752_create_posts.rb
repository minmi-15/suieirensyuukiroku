class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :distance
      t.string :stroke
      t.string :time
      t.references :user, null: false, foreign_key: true
      t.date :practice_day

      t.timestamps
    end
  end
end
