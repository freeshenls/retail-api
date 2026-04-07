class AddPrintStatusToBizOrder < ActiveRecord::Migration[8.1]
  def change
    add_column :biz_order, :printed_at, :datetime
    add_column :biz_order, :printed_by_id, :integer
  end
end
