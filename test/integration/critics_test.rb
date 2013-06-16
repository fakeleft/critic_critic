require 'test_helper'

class CriticsViewTest < ActionDispatch::IntegrationTest

  describe 'Critics pages' do
    describe 'Critics home' do

      it "should have the title 'Movie Critic | All Critics'" do
        visit '/critics'
        page.must_have_title('Movie Critic | All Critics')
      end

      it "should have h1 'All Critics'" do
        visit '/critics'
        page.must_have_selector('h1', text:'All Critics')
      end
    end
  end
end
