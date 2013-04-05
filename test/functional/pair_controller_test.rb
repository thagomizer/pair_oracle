require 'test_helper'

class PairControllerTest < ActionController::TestCase
  def setup
    @fred = people(:fred)
    @barney = people(:barney)
    @wilma = people(:wilma)
  end

  def test_get_select
    get :select

    assert_response :success

    Person.all.each do |person|
      assert response.body.include? person.name
    end

    # There needs to be a form
    assert_select "form", 1

    # With a checkbox for each person
    assert_select "input#people_ids_", Person.count

    # And a submit button
    assert_select "input[type='submit']"
  end

  def test_post_generate
    post :generate, "people" => {"ids" => [@wilma, @fred, @barney]}

    assert_equal 3, assigns(:pairs).length

    body = response.body

    # assert body.include?("Fred & Barney, Wilma")
    # assert body.include?("Fred & Wilma, Barney")
    # assert body.include?("Barney & Wilma, Fred")
  end
end
