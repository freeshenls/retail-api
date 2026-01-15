class CreateBizOrder < ActiveRecord::Migration[8.1]
  def change
    create_table :biz_order do |t|
      t.string :order_no, null: false, index: { unique: true }

      t.references :draft, foreign_key: { to_table: :biz_draft }
      t.string :draft_name

      t.references :customer, foreign_key: { to_table: :biz_customer }
      t.string :customer_name

      t.string :service_type
      t.string :category_name
      t.references :unit, foreign_key: { to_table: :biz_unit }

      t.string :payment_method
      t.text :remark

      t.decimal :quantity, precision: 10, scale: 2, default: 0
      t.decimal :unit_price, precision: 10, scale: 4, default: 0
      t.decimal :amount, precision: 10, scale: 4, default: 0
      t.decimal :delivery_fee, precision: 10, scale: 2, default: 0
      t.string :delivery_method

      t.string :status, default: 'pending', null: false
      t.boolean :is_settled, default: false, index: true

      t.references :staff, foreign_key: { to_table: :sys_user }
      t.timestamps
    end
  end
end
