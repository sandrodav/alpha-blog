class Article < ApplicationRecord
  paginates_per 5
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
  validates :title , presence: true ,length: { minimum: 3 ,maxsimum: 50}
  validates :description , presence: true , length: { minimum: 10 ,maxsimum: 300}
  validates :user_id ,presence:true

end
