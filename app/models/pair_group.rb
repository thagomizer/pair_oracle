class PairGroup
  include ActiveModel::AttributeMethods
  include Enumerable

  attr_accessor :pairs
  define_attribute_methods ['pairs']

  def initialize
    self.pairs = []
  end

  def to_s
    self.pairs.map(&:to_s).join(", ")
  end

  def to_a
    self.pairs.map(&:to_a).flatten.compact
  end

  def save
    self.pairs.map(&:save).all?
  end

  def self.from_ids(ids)
    pg = PairGroup.new

    people = ids.map { |id| Person.find(id) }
    pg.pairs = people.each_slice(2).map { |p1, p2| Pair.make_pair(p1, p2) }
    pg
  end

  def self.generate(people)
    people.sort!

    if people.length == 1
      pg = PairGroup.new
      pg.pairs << Pair.make_pair(people[0])
      return [pg]
    end

    if people.length == 2
      pg = PairGroup.new
      pg.pairs << Pair.make_pair(people[0], people[1])
      return [pg]
    end

    pair_groups = []
    people.combination(2).each do |person_1, person_2|
      pair = Pair.make_pair(person_1, person_2)
      others = self.generate(people - pair.to_a)
      others.each do |rest|
        rest.pairs.unshift pair
        pair_groups << rest
      end
    end

    return pair_groups
  end

  def each(&block)
    self.pairs.each do |pair|
      yield pair
    end
  end
end
