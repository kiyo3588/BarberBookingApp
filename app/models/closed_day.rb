class ClosedDay < ApplicationRecord
  validates :date, presence: true, uniqueness: true

  # 指定された日が休業日かどうかをチェック
  def self.closed?(date)
    exists?(date: date)
  end

  # 期間内の休業日を取得
  def self.in_range(start_date, end_date)
    where(date: start_date..end_date)
  end
end
