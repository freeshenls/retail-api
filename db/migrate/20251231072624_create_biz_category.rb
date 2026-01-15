class CreateBizCategory < ActiveRecord::Migration[8.1]
  def change
    # 显式指定表名为单数 biz_category
    create_table :biz_category do |t|
      t.string :name, null: false
      t.integer :position, default: 0

      t.timestamps
    end
    add_index :biz_category, :name, unique: true
  end
end