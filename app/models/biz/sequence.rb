# app/models/biz/sequence.rb
class Biz::Sequence < ApplicationRecord
  # 定义一个专门获取格式化编号的方法
  def self.generate_next_no(prefix: "")
    t = Time.current
    y = t.strftime('%Y')
    m = t.strftime('%m')

    # 将事务锁定在 Sequence 模型内部
    transaction do
      # 寻找并锁定当前年月的计数行
      seq = lock(true).find_or_create_by!(year: y, month: m)
      
      # 递增并保存
      seq.serial_no += 1
      seq.save!

      # 返回格式化后的字符串
      "#{prefix}#{y}#{m}#{format('%03d', seq.serial_no)}"
    end
  end
end
