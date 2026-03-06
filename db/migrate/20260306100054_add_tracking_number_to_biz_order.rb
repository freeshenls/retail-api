class AddTrackingNumberToBizOrder < ActiveRecord::Migration[8.1]
  def change
    add_column :biz_order, :tracking_number, :string
    
    # 给单号加索引，因为以后查物流单号肯定会非常频繁
    add_index :biz_order, :tracking_number
  end
end
