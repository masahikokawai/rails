class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  # 逆リレーションシップを使用してuser.followersを実装
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  # :sourceキーを省略してもよいことにも注意
  # :followers属性の場合、Railsが “followers” を単数形にして自動的に外部キーfollower_idを探してくれるから (:followedではこうはいかない)
  # コードでは、関連付けがhas_many :followed_usersと同じ形式になることを強調するために、あえて:sourceキーを付けてあるが、もちろん省略可
  has_many :followers, through: :reverse_relationships, source: :follower

  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
#                    uniqueness: { case_sensitive: false }
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    # このコードは準備段階です。
    # 完全な実装は第11章「ユーザーをフォローする」を参照してください。
    #Micropost.where("user_id = ?", id)

    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    # フォローする相手のユーザーがデータベース上に存在するかどうかをチェック
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    # relationships関連付けを経由してcreate!を呼び出すことで、「フォローする」のリレーションシップを作成
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    # ユーザーのリレーションシップを削除してフォロー解除
    relationships.find_by(followed_id: other_user.id).destroy
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
