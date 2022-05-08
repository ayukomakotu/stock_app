class Stock < ApplicationRecord
  belongs_to :item
  # 入出庫の計算　出庫ならstockからprocess_numberをひいた値を返す、入庫なら足した値を返す
end
