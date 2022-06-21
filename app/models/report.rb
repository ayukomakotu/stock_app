class Report < ApplicationRecord
  belongs_to :user
  #confrimer_idを参照して,対応するuserを表示
  belongs_to :confirmer, class_name: "User",
                        foreign_key: "confirmer_id",
                           optional: true
  belongs_to :item
  validates :process, presence: true
  validates :process_number, presence: true
  validates :day, presence: true

  # scope :day_between, -> from, to {
  #   if from.present? && to.present?
  #     where(day: from..to)
  #   elsif from.presnet?
  #     where('day >= ?', from)
  #   elsif to.present?
  #     where('day <= ?', to)
  #   end
  # }

  # 絞込み用　monthがあればmonthで検索、itemがあればitemで検索, 両方あれば両方で検索
  scope :search, -> month, item {
    if month.present? && item.present?
      month_between(month).where(item_id: item)
    elsif month.present?
      month_between(month)
    elsif item.present?
      where(item_id: item)
    else
      self
    end
  }
  scope :month_between, -> month {
    where(day: Date.parse("#{month}-1").all_month)
  }
end
