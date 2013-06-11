class User < ActiveRecord::Base
  has_many :user_opinions
end
