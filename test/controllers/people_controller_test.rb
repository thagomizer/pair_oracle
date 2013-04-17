require "test_helper"

class PeopleControllerTest < ActionController::TestCase

  before do
    @person = people(:fred)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:people)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Person.count') do
      post :create, :person => { :name => @person.name  }
    end

    assert_redirected_to person_path(assigns(:person))
  end

  def test_show
    get :show, :id => @person
    assert_response :success
  end

  def test_edit
    get :edit, :id => @person
    assert_response :success
  end

  def test_update
    put :update, :id => @person
    assert_redirected_to person_path(assigns(:person))
  end

  def test_destroy
    assert_difference('Person.count', -1) do
      delete :destroy, :id => @person
    end

    assert_redirected_to people_path
  end
end
