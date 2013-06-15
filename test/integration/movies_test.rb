require 'test_helper'

class MoviesViewTest < ActionDispatch::IntegrationTest
#class MoviesViewTest < Unit::Test

  describe 'Movies pages' do
    describe 'Movies index' do

      it "should have the content 'Listing movies'" do
        visit '/movies'
        page.must_have_content('Listing movies')
      end
    end
  end
end
