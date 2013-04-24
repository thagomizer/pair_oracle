require "test_helper"

class PairGroupTest < ActiveSupport::TestCase
  def setup
    @fred  = people(:fred)
    @barney = people(:barney)
    @wilma = people(:wilma)
  end

  def test_generate_one_person
    expected_pair = Pair.new(:person_1 => @wilma)
    pair_sets = PairGroup.generate([@wilma])
    pair_set = pair_sets.first
    pair = pair_set.first

    assert_equal 1, pair_sets.length
    assert_equal 1, pair_set.length
    assert_equal expected_pair.person_1, pair.person_1
  end

  def test_generate_two_people
    expected_pair = Pair.new(:person_1 => @barney, :person_2 => @fred)
    pair_sets = PairGroup.generate([@fred, @barney])
    pair_set = pair_sets.first
    pair = pair_set.first

    assert_equal 1, pair_sets.length
    assert_equal 1, pair_set.length
    assert_equal expected_pair.person_1, pair.person_1
    assert_equal expected_pair.person_2, pair.person_2
  end

  def test_generate_three_people
    pair_sets = PairGroup.generate([@fred, @barney, @wilma])

    assert_equal 3, pair_sets.length
    pair_sets.each do |pair_set|
      assert_equal 2, pair_set.length

      folks = pair_set.map { |pair| [pair.person_1, pair.person_2]}.flatten
      assert_includes folks, @fred
      assert_includes folks, @barney
      assert_includes folks, @wilma
    end
  end
end
