class CreateSysInviteCode < ActiveRecord::Migration[8.1]
  def change
    create_table :sys_invite_code do |t|
      t.string :code, null: false
      t.references :role, null: false
      t.datetime :expired_at
      t.datetime :used_at
      t.references :user, foreign_key: { to_table: :sys_user }

      t.timestamps
    end
  end
end
