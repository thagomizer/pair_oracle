class PairController < ApplicationController
  def select
    @people = Person.all
  end

  def generate
    ids = params["people"]["ids"]
    people = ids.map { |id| Person.find(id) }

    @pair_groups = PairGroup.generate(people)
  end
end
