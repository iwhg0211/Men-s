class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.string :shop_name, null: false
      t.text :shop_explanation, null: false
      t.string :address
      t.integer :latitude
      t.integer :longitude
      t.boolean :is_deleted, null: false, default: ""

      t.timestamps
    end
  end
end
