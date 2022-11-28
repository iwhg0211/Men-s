class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :post, null: false, foreign_key: true
      t.string :review_title, null: false
      t.text :shop_review, null: false

      t.timestamps
    end
  end
end
