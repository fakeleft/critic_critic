require 'test_helper'

class CriticsViewTest < ActionDispatch::IntegrationTest

  describe 'Critics pages' do
    describe 'Critics home' do

      it "should have the title 'Movie Critic'" do
        visit '/critics'
        page.must_have_title('Movie Critic')
      end

      it "should have the content 'Listing All Critics'" do
        visit '/critics'
        page.must_have_content('Listing All Critics')
      end
    end
  end
end