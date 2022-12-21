class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.string :shop_name
      t.text :shop_explanation
      t.string :address
      t.float :latitude
      t.float :longitude
      t.boolean :is_released, null: false, default: "true"

      t.timestamps
    end
  end
end
