require 'test_helper'

class PairControllerTest < ActionController::TestCase
  def setup
    @fred = people(:fred)
    @barney = people(:barney)
    @wilma = people(:wilma)
  end

  def test_select
    get :select

    assert_response :success

    Person.all.each do |person|
      assert response.body.include? person.name
    end

    assert_select "form", 1

    assert_select "input#people_ids_", Person.count

    assert_select "input[type='submit']"
  end

  def test_generate
    post :generate, "people" => {"ids" => [@wilma, @fred, @barney].map(&:id)}

    assert_equal 3, assigns(:pair_groups).length

    body = response.body
    assert body.include?("Barney &amp; Fred, Wilma")
    assert body.include?("Wilma &amp; Fred, Barney")
    assert body.include?("Wilma &amp; Barney, Fred")
  end

  def test_generate_scores_the_pairs
    Pair.make_pair(@wilma, @fred).save!
    Pair.make_pair(@wilma, @fred).save!
    Pair.make_pair(@wilma, @barney).save!

    post :generate, "people" => {"ids" => [@wilma, @fred, @barney].map(&:id)}

    pair_groups = assigns(:pair_groups)
    assert_equal Pair.make_pair(@barney, @fred), pair_groups[0][0]
    assert_equal Pair.make_pair(@wilma, @barney), pair_groups[1][0]
    assert_equal Pair.make_pair(@wilma, @fred), pair_groups[2][0]
  end

  def test_save
    assert_difference 'Pair.count', 2 do
      post :save, "pairs" => "#{[@fred, @barney, @wilma].map(&:id)}"
    end

    last_id = Pair.last.id
    pair_2 = Pair.find(last_id)
    pair_1 = Pair.find(last_id - 1)

    assert_equal @fred, pair_1.person_1
    assert_equal @barney, pair_1.person_2
    assert_equal @wilma, pair_2.person_1
    assert_nil pair_2.person_2
  end
end
