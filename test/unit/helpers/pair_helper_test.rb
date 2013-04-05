require 'test_helper'

class PairHelperTest < ActionView::TestCase
  def setup
    @fred = people(:fred)
    @barney = people(:barney)
    @wilma = people(:wilma)
  end

  # def test_pp_pairs_one_user
  #   assert_equal "Fred", pp_pair([@fred])
  # end

  # def test_pp_pairs_two_users
  #   assert_equal "Fred & Barney", pp_pair([@fred, @barney])
  # end

  # def test_pp_pairs_three_users
  #   assert_equal "Wilma & Fred, Barney", pp_pair([[@wilma, @fred], @barney])
  # end
end
