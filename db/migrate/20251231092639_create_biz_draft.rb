class CreateBizDraft < ActiveRecord::Migration[8.1]
  def change
    create_table :biz_draft do |t|
      t.string :name, limit: 255
      t.string :file_type, limit: 20
      t.text :file_path
      t.datetime :upload_time, default: -> { "now()" }

      t.references :user, null: false, foreign_key: { to_table: :sys_user }

      t.timestamps
    end
  end
end
