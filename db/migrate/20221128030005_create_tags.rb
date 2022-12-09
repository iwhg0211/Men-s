class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :tag_name, null: false

      t.timestamps
      
      # tag_name で検索するため index を貼り 一意制約を設定
      t.index :tag_name, unique: true
    end
  end
end
