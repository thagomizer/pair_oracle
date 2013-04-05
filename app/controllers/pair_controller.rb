class PairController < ApplicationController
  def select
    @people = Person.all
  end

  def generate
    ids = params["people"]["ids"]

    @pairs = Pair.generate(ids)
  end
end
