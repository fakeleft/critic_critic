require 'test_helper'

class UsersViewTest < ActionDispatch::IntegrationTest

  describe 'Users pages' do
    describe 'Users home' do

      it "should have the title 'Movie Critic'" do
        visit '/users'
        page.must_have_title('Movie Critic')
      end

      it "should have the content 'Listing users'" do
        visit '/users'
        page.must_have_content('Listing users')
      end
    end
  end
end
