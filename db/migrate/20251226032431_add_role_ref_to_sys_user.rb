class AddRoleRefToSysUser < ActiveRecord::Migration[8.1]
  def change
    add_reference :sys_user, :role, null: false, foreign_key: { to_table: :sys_role }
  end
end
