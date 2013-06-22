class UserCriticMatches
  attr_reader :user,:matches
  def initialize(user=User.first)
    @user = user
    @matches ||= []
  end

  def add_match(match)
    @matches << match
  end

  def take(num_of_matches=5)
    @matches.take(5)
  end

  def sort_matches
    @matches.sort_by do |match|
        match.disagree - match.agree
    end
  end


end

class Match
  attr_accessor :critic, :agree, :disagree, :movie_id
  def initialize(critic=nil, movie_id=nil, agree=nil, disagree=nil)
    @critic   ||= critic
    @movie_id ||= movie_id
    @agree    ||= agree
    @disagree ||= disagree
  end
  def opinion(agree, disagree)
    @agree    = agree
    @disagree = disagree
    return self
  end
end

