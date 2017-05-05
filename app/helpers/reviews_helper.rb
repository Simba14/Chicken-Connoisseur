module ReviewsHelper
  def star_rating(rating)
    return rating unless rating.respond_to?(:round)
    '🔥' * rating.round + " #{rating}/5"
  end
end
