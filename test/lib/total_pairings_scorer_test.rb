require 'test_helper'

class TestTotalPairingsScorer < ActiveSupport::TestCase

  def setup
    @fred  = people(:fred)
    @barney = people(:barney)
    @wilma = people(:wilma)
  end

  def test_score_no_history
    pair_group = PairGroup.from_ids([@fred, @barney, @wilma].map(&:id))

    score = TotalPairingsScorer.score(pair_group)
    assert_equal 0, score
  end

  def test_score_with_history
    pair_group = PairGroup.from_ids([@fred, @barney, @wilma].map(&:id))

    Pair.make_pair(@fred, @barney).save!

    score = TotalPairingsScorer.score(pair_group)
    assert_equal 1, score

    Pair.make_pair(@fred, @barney).save!
    Pair.make_pair(@wilma).save!

    score = TotalPairingsScorer.score(pair_group)
    assert_equal 3, score
  end
end
