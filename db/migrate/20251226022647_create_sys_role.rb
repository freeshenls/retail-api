class CreateSysRole < ActiveRecord::Migration[8.1]
  def change
    create_table :sys_role do |t|
      t.string :name, null: false
      t.string :description

      t.timestamps
    end

    add_index :sys_role, :name,                unique: true
  end
end
