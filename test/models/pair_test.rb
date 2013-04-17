require "test_helper"

class PairTest < ActiveSupport::TestCase
  def setup
    @wilma = Person.create!(:name => "Wilma")
    @barney = Person.create!(:name => "Barney")
    @fred = Person.create!(:name => "Fred")
  end

  def test_pair_valid_if_it_has_two_people
    pair = Pair.new(:person_1 => @wilma, :person_2 => @barney)
    assert pair.valid?
  end

  def test_pair_valid_if_it_has_person_1
    pair = Pair.new(:person_1 => @wilma)
    assert pair.valid?
  end

  def test_pair_invalid_if_it_only_has_person_2
    pair = Pair.new(:person_2 => @wilma)
    assert !pair.valid?
  end

  def test_pair_invalid_if_it_has_no_people
    pair = Pair.new()
    assert !pair.valid?
  end

  def test_sanity
    assert_equal @wilma, Person.find(@wilma.id)
  end

  def test_generate_when_passed_only_one_id
    pairs = Pair.generate([@wilma.id])

    assert_equal [[[@wilma]]], pairs
  end

  def test_generate_returns_users_ordered_by_id
    pairs = Pair.generate([@fred.id, @wilma.id])

    assert_equal [[[@wilma, @fred]]], pairs
  end

  def test_generate_when_passed_three_ids
    pairs = Pair.generate([@fred, @wilma, @barney].map(&:id))

    expected = [[[@wilma, @fred], [@barney]],
                [[@barney, @fred], [@wilma]],
                [[@wilma, @barney], [@fred]]]

    assert_equal expected.length, pairs.length
    assert_equal expected, pairs
  end
end
