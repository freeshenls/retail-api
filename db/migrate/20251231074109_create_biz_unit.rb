class CreateBizUnit < ActiveRecord::Migration[8.1]
  def change
    # 显式指定表名为单数 biz_unit
    create_table :biz_unit do |t|
      # 业务类型：出片、数印等
      t.string :service_type, null: false
      
      # 关联规格表，注意这里字段名会是 biz_category_id
      t.references :category, null: false, foreign_key: { to_table: :biz_category }
      
      # 价格使用精度更高的 decimal
      t.decimal :price, null: false, precision: 10, scale: 4, default: 0.0
      
      t.string :currency, null: false, default: "CNY"
      t.string :status, default: "1"

      t.timestamps
    end

    add_index :biz_unit, [:service_type, :category_id]
  end
end