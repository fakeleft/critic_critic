require 'test_helper'

class CriticsViewTest < ActionDispatch::IntegrationTest

  describe 'Critics index' do
    it "should have title 'Browsing Critics | Critic Critic" do
      visit '/critics'
      page.must_have_title('Browsing Critics | Critic Critic')
    end

    it "should have h2 'Browsing Critics" do
      visit '/critics'
      page.must_have_selector('h2', text:'Browsing Critics')
    end

    it "should have table of critics" do
      visit '/critics'
      page.must_have_css('table')
      # page.must_have_selector('table', class:'movie table-striped')
    end
  end

end
