class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.datetime :posted_at
      t.references :place, null: true, foreign_key: true

      t.timestamps
    end
  end
end
