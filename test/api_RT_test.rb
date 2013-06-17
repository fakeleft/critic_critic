require_relative 'test_helper'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = "spec/*_spec.rb"
end

class UserTest < ActiveSupport::TestCase
  described_class # => User(id: integer, email: string)
  it 'works here' do
    described_class # => User(id: integer, email: string)
  end
  describe 'and' do
    it 'works here too' do
      described_class # => User(id: integer, email: string)
    end
  end
end