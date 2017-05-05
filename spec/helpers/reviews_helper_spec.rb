require 'rails_helper'

describe ReviewsHelper, :type => :helper do
  context '#star_rating' do
    it 'does nothing for not a number' do
      expect(helper.star_rating('N/A')).to eq 'N/A'
    end

    it 'returns 5 flames for 5' do
      expect(helper.star_rating(5)).to eq '🔥🔥🔥🔥🔥 5/5'
    end

    it 'returns 4 flames for 4' do
      expect(helper.star_rating(4)).to eq '🔥🔥🔥🔥 4/5'
    end
  end
end
