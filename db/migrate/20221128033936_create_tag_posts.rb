class CreateTagPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_posts do |t|
      t.references :tag, null: false, foreign_key: true, unique: true
      t.references :post, null: false, foreign_key: true, unique: true

      t.timestamps
    end
  end
end