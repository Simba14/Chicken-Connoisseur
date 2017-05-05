class Restaurant < ApplicationRecord

  has_many :reviews, dependent: :destroy
  belongs_to :user

  validates :name, length: { minimum: 3 }, uniqueness: true

  def build_review(review_params, user)
    review = user.reviews.new(review_params)
    review.update(restaurant_id: self.id)
    review
  end

  def average_rating
    if self.reviews == []
      "N/A"
    else
      total = 0
      self.reviews.each do |review|
        total += review.rating
      end
      self.rating = total / self.reviews.length
    end
  end

end
