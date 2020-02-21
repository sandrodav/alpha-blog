class ArticleCategory < ApplicationRecord
  paginates_per 5 
  belongs_to :article
  belongs_to :category
end
