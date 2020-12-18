class Book < ApplicationRecord
	belongs_to :user
	validates :title, presence: true
	validates :body ,presence: true, length: {maximum: 200}

    has_many :favorites
    has_many :book_comments

    # 検索機能

    def Book.search(search, user_or_book, how_seach)
        if how_seach == "1"
            Book.where(['title LIKE ?', "%#{search}%"])
        elsif how_seach == "2"
            Book.where(['title LIKE ?', "%#{search}"])
        elsif how_seach == "3"
            Book.where(['title LIKE ?', "#{search}%"])
        elsif how_seach == "4"
            Book.where(['title LIKE ?', "#{search}"])
        else
            Book.all
        end
    end
end
