require "test_helper"

class PersonTest < ActiveSupport::TestCase
  def test_name_required
    person = Person.new()

    assert !person.valid?

    person.name = "Fred"

    assert person.valid?
  end
end
