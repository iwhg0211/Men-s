class AddImpressionsCountToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :impressions_count, :int, null: false, default: 0
  end
end
