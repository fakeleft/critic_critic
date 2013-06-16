require 'test_helper'

class MoviesViewTest < ActionDispatch::IntegrationTest

  describe 'Movies pages' do
    describe 'Movies home' do

      it "should have the title 'Movie Critic | Listing movies'" do
        skip
        visit '/movies'
        page.must_have_title('Movie Critic | Listing movies')
      end

      it "should have h1 'Listing movies'" do
        visit '/movies'
        page.must_have_selector('h1', text:'Listing movies')
      end

      it "should have the content 'Listing movies'" do
        visit '/movies'
        page.must_have_content('Listing movies')
      end

    end
  end
end
