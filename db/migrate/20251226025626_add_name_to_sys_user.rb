class AddNameToSysUser < ActiveRecord::Migration[8.1]
  def change
    add_column :sys_user, :name, :string
  end
end
