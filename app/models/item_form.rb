class ItemForm
    include ActiveModel::Model # 通常のモデルのようにvalidationなどを使えるようにする
    include ActiveModel::Attributes # ActiveRecordのカラムのような属性を加えられるようにする
    # StockFormでメソッドとして使えるようにする
    attr_accessor :name, :number, :unit
    # validationをひとまとめにする
    with_options presence: true do
        validates :name
        validates :number
        validates :unit
    end

    # 0以上でなければならない
    validates :number, numericality: { greater_than_or_equal_to: 0 }
    

    def save
        item = Item.create(name: name, unit: unit)
        Stock.create(item_id: item.id, number: number)
    end

end