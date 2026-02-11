class CreateBizNotification < ActiveRecord::Migration[8.1]
  def change
    create_table :biz_notification do |t|
      t.references :user, null: false, foreign_key: { to_table: :sys_user }
      t.references :actor, polymorphic: true, null: false
      t.references :target, polymorphic: true, null: false
      t.string :action
      t.json :metadata
      t.datetime :read_at

      t.timestamps
    end
    add_index :biz_notification, :read_at
  end
end
