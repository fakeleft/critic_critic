require 'test_helper'

class CriticOpinionsViewTest < ActionDispatch::IntegrationTest

  describe 'Critic Opinions pages' do
    describe 'Critic Opinions home' do

      it "should have the title 'Movie Critic'" do
        visit '/critic_opinions'
        page.must_have_title('Movie Critic')
      end

      it "should have the content 'List of Critic Opinions'"

    end
  end
end
