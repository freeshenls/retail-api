class CreateBizCustomer < ActiveRecord::Migration[8.1]
  def change
    create_table :biz_customer do |t|
      t.string :name, limit: 100
      t.string :address, limit: 255
      t.string :card_name, limit: 20
      t.string :card_no, limit: 30
      t.decimal :credit_limit, null: false, precision: 10, scale: 4, default: 0.0

      t.timestamps
    end
  end
end
