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

  def test_to_a
    pair = Pair.new(:person_1 => @wilma, :person_2 => @fred)

    assert_equal [pair.person_1, pair.person_2], pair.to_a
  end

  def test_make_pair
    result = Pair.make_pair(@wilma, @fred)

    assert_equal Pair.new(:person_1 => @wilma, :person_2 => @fred), result

    result = Pair.make_pair(@wilma)

    assert_equal Pair.new(:person_1 => @wilma), result
  end

  def test_to_s_two_people
    p = Pair.make_pair(@wilma, @fred)

    assert_equal "Wilma & Fred", p.to_s
  end

  def test_to_s_one_person
    p = Pair.make_pair(@wilma)

    assert_equal "Wilma", p.to_s
  end
end
