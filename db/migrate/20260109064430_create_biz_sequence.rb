class CreateBizSequence < ActiveRecord::Migration[8.1]
  def change
    create_table :biz_sequence do |t|
      t.string :year #2026
      t.string :month #01
      t.integer :serial_no, default: 0
      t.timestamps
    end
    
    add_index :biz_sequence, [:year, :month], unique: true
  end
end
