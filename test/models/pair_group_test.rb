require "test_helper"

class PairGroupTest < ActiveSupport::TestCase
  def setup
    @fred  = people(:fred)
    @barney = people(:barney)
    @wilma = people(:wilma)
  end

  def test_generate_one_person
    expected_pair = Pair.make_pair(@wilma)
    pair_groups = PairGroup.generate([@wilma])
    pair_group = pair_groups.first
    pair = pair_group.pairs.first

    assert_equal 1, pair_groups.length
    assert_equal expected_pair.person_1, pair.person_1
    assert_nil pair.person_2
  end

  def test_generate_two_people
    expected_pair = Pair.make_pair(@barney, @fred)
    pair_groups = PairGroup.generate([@fred, @barney])
    pair_group = pair_groups.first
    pair = pair_group.pairs.first

    assert_equal 1, pair_groups.length
    assert_equal expected_pair.person_1, pair.person_1
    assert_equal expected_pair.person_2, pair.person_2
  end

  def test_generate_three_people
    pair_groups = PairGroup.generate([@fred, @barney, @wilma])

    assert_equal 3, pair_groups.length
    pair_groups.each do |pair_group|
      assert_equal 2, pair_group.pairs.length

      folks = pair_group.to_a
      assert_includes folks, @fred
      assert_includes folks, @barney
      assert_includes folks, @wilma
    end
  end

  def test_to_s
    pair_1 = Pair.make_pair(@fred, @barney)
    pair_2 = Pair.make_pair(@wilma)
    pair_group = PairGroup.new
    pair_group.pairs << pair_1
    pair_group.pairs << pair_2

    expected_str = "Fred & Barney, Wilma"

    assert_equal expected_str, pair_group.to_s
  end

  def test_to_a
    pair_group = PairGroup.from_ids([@fred, @barney, @wilma].map(&:id))

    assert_equal [@fred, @barney, @wilma].sort, pair_group.to_a.sort
  end

  def test_from_ids
    pg = PairGroup.from_ids [@fred, @barney, @wilma].map(&:id)

    assert_equal 2, pg.pairs.length
    p1 = pg.pairs[0]
    p2 = pg.pairs[1]

    assert_equal @fred, p1.person_1
    assert_equal @barney, p1.person_2
    assert_equal @wilma, p2.person_1
    assert_nil p2.person_2
  end

  def test_save
    pg = PairGroup.from_ids [@fred, @barney, @wilma].map(&:id)

    assert_difference 'Pair.count', 2 do
      pg.save
    end

    last_id = Pair.last.id
    pair_2 = Pair.find(last_id)
    pair_1 = Pair.find(last_id - 1)

    assert_equal @fred, pair_1.person_1
    assert_equal @barney, pair_1.person_2
    assert_equal @wilma, pair_2.person_1
    assert_nil pair_2.person_2
  end

  def test_square_bracket
    pg = PairGroup.from_ids [@fred, @barney, @wilma].map(&:id)

    assert_instance_of(Pair, pg[0])
  end
end
