class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
        attachment :profile_image, destroy: false
  has_many :books
  has_many :favorites
  has_many :book_comments
  validates :name, presence: true, length: {maximum: 10, minimum: 2}
  validates :introduction, length: {maximum: 50}

  # 自分をフォローしている人
  has_many :followed, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  has_many :follower_user, through: :followed, source: :follower

  # 自分がフォローしている人
  has_many :follower, foreign_key: "follower_id", class_name: 'Relationship', dependent: :destroy
  has_many :following_user, through: :follower, source: :followed

  def following?(user)
    following_user.include?(user)
  end

  def follow(user_id)
    follower.create!(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # いいね機能
  def favorited_by?(book_id)
    favorites.where(book_id: book_id).exists?
  end


  # 検索機能
  def User.search(search, user_or_book, how_seach)
    if user_or_book == "1"
      if how_seach == "1"
        User.where(['name LIKE ?', "%#{search}%"])
      elsif how_seach == "2"
        User.where(['name LIKE ?', "%#{search}"])
      elsif how_seach == "3"
        User.where(['name LIKE ?', "#{search}%"])
      elsif how_seach == "4"
        User.where(['name LIKE ?', "#{search}"])
      else
        User.all
      end
    end
  end
end
