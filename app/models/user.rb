class User < ApplicationRecord
    attr_accessor :remember_token
    has_many :reports
    validates :name, presence: true
    validates :number, presence: true, uniqueness: true
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }

    class << self #selfを省略
        # 渡された文字列のハッシュ値を返す
        def digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                        BCrypt::Engine.cost
            BCrypt::Password.create(string, cost: cost)
        end

        # ランダムなトークンを返す
        def new_token
            SecureRandom.urlsafe_base64
        end
    end

    # 永続セッションのためにユーザーをデータベースに記憶する
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # 渡されたトークンがダイジェストと一致したらtrueを返す
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

        # ユーザーのログイン情報を破棄する
    def forget
        update_attribute(:remember_digest, nil)
    end
end
