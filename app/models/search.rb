class Search < ApplicationRecord
  validates :url,
            presence: true,
            format: { with: /https:\/\/www\.pinkbike\.com\/buysell\/list\/?/,
                      message: 'Must be a pb url' }
  validates :name,
            presence: true,
            length: { minimum: 1, maximum: 40 }
  validates_uniqueness_of :url, :name
end
