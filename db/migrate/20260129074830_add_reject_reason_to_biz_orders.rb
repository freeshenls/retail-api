class AddRejectReasonToBizOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :biz_order, :reject_reason, :text
  end
end
