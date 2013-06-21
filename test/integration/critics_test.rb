require 'test_helper'

class CriticsViewTest < ActionDispatch::IntegrationTest

  describe 'Critics pages' do
    describe 'Critics home' do

      it "should have the title 'Browsing Critics | Critic Critic'" do
        skip
        visit '/critics'
        page.must_have_title('Browsing Critics | Critic Critic')
      end

      it "should have h2 'Browsing Critics" do
        visit '/critics'
        page.must_have_selector('h2', text:'Browsing Critics')
      end
    end
  end
end
