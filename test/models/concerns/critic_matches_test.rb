# require 'test_helper'
require "minitest/autorun"
require_relative '../../../app/models/concerns/user_critic_matches.rb'

describe "UserCriticMatches" do
  before do
      @user = MiniTest::Mock.new
      @user_matches = UserCriticMatches.new(@user)
    end
  describe "has a user object on assignment" do
    it "responds to: name and id" do
      @user.expect(:name, "Dustin")
      @user.expect(:id, 1)
      @user_matches.user.name
      @user_matches.user.id
      @user.verify
    end
  end

  describe "has a match object" do
    before do
      @critic = MiniTest::Mock.new
      @match = MiniTest::Mock.new
      @match.expect(:critic, @critic)
      @critic.expect(:name, "Tom Jones")
      @user_matches = UserCriticMatches.new(@user)
      @user_matches.add_match(@match)
    end

    it "can respond to critic.name" do
      @critic.expect(:name, "Tom Jones")
      match = @user_matches.matches.first
      match.critic.name.must_equal "Tom Jones"
    end
    it "can respond critic.id" do
      @critic.expect(:id, 123)
      match = @user_matches.matches.first
      match.critic.id.must_equal 123
    end
    it "can respond to agree and disagree" do
      @match.expect(:agree, 10)
      @match.expect(:disagree, 0)
      match = @user_matches.matches.first
      match.agree.must_equal 10
      match.disagree.must_equal 0
    end
  end

  describe "sort_matches and take" do
    before do
      agree_disagree = [
        [3, 2], [7, 1], [2, 1],
        [4, 3], [1, 1], [0, 10]
      ]
      agree_disagree.each do |opinion|
        @user_matches.add_match Match.new.opinion(*opinion)
      end
    end
    describe "sort_matches" do
      it "it sorts matches" do
        sorted_list = @user_matches.sort_matches
        sorted_list.first.agree.must_equal 7
        sorted_list.last.disagree.must_equal 10
      end
    end
    describe "take" do
      it "returns the top sorted matches limited by input" do
        @user_matches.take(5).length.must_equal 5
      end
    end
  end

end

