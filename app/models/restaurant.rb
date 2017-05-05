class Restaurant < ApplicationRecord

  attr_reader :image

  has_many :reviews, dependent: :destroy
  belongs_to :user

  validates :name, length: { minimum: 3 }, uniqueness: true

  def build_review(review_params, user)
    review = user.reviews.new(review_params)
    review.update(restaurant_id: self.id)
    review
  end

  has_attached_file :image, :styles => { :medium => '300x300>', :thumb => '100x100>' }, :default_url => "/images/:style/take_it_easy.jpg"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
