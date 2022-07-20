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

  scope :day_between, -> from, to {
    if from.present? && to.present?
      where(day: from..to)
    elsif from.present?
      where('day >= ?', from)
    elsif to.present?
      where('day <= ?', to)
    end
  }

  
  # 絞込み用　monthがあればmonthで検索、itemがあればitemで検索, 両方あれば両方で検索
  # month_fieldがsafariで非対応のため仕様変更
  # scope :search, -> month, item {
  #   if month.present? && item.present?
  #     month_between(month).where(item_id: item)
  #   elsif month.present?
  #     month_between(month)
  #   elsif item.present?
  #     where(item_id: item)
  #   else
  #     self
  #   end
  # }

  scope :search, -> from, to, item {
    if item.present?
      if from.present? && to.present?
        where(day: from..to).where(item_id: item)
      elsif from.present?
        where('day >= ?', from).where(item_id: item)
      elsif to.present?
        where('day <= ?', to).where(item_id: item)
      else
        where(item_id: item)
      end
    else
      if from.present? && to.present?
        where(day: from..to)
      elsif from.present?
        where('day >= ?', from)
      elsif to.present?
        where('day <= ?', to)
      else
        self
      end
    end
  }

  scope :month_between, -> month {
    where(day: Date.parse("#{month}-1").all_month)
  }
end
