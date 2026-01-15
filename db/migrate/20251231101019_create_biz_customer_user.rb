class CreateBizCustomerUser < ActiveRecord::Migration[8.1]
  def change
    create_table :biz_customer_user do |t|
      t.references :customer, null: false, foreign_key: { to_table: :biz_customer }
      t.references :user, null: false, foreign_key: { to_table: :sys_user }

      t.timestamps
    end
  end
end
