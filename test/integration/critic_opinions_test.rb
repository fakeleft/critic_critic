require 'test_helper'

class CriticOpinionsViewTest < ActionDispatch::IntegrationTest

  describe 'Critic Opinions pages' do
    describe 'Critic Opinions home' do

      it "should have the title 'Movie Critic | List of Critic Opinions'" do
        skip
        visit '/critic_opinions'
        page.must_have_title('Movie Critic | List of Critic Opinions')
      end

      it "should have h1 'List of Critic Opinions'" do
        skip
        visit '/critic_opinions'
        page.must_have_selector('h1', text:'List of Critic Opinions')
      end

    end
  end
end
