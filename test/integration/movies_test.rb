require 'test_helper'

class MoviesViewTest < ActionDispatch::IntegrationTest

  describe 'Movies pages' do
    describe 'Movies home' do

      it "should have the title 'Movie Critic | Listing movies'" do
        skip
        visit '/movies'
        page.must_have_title('Movie Critic | Listing movies')
      end

      it "should have h1 'Browse Movies'" do
        visit '/movies'
        page.must_have_selector('h1', text:'Browse Movies')
      end

      it "should have the content 'Browse Movies'" do
        visit '/movies'
        page.must_have_content('Browse Movies')
      end

    end
  end
end
