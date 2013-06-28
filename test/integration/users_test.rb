require 'test_helper'

class UsersViewTest < ActionDispatch::IntegrationTest

  describe 'Users pages' do

      it "should have the title 'Matched Critics | Critic Critic'" do
        skip
        visit '/users'
        page.must_have_title('Matched Critics | Critic Critic')
      end

      it "should have h2 'Matched Critics'" do
        visit '/users'
        page.must_have_selector('h2', text:'Matched Critics')
      end
  end

end
