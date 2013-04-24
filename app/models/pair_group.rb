class PairGroup
  def self.generate(people)
    people.sort!

    return [[Pair.new(:person_1 => people[0])]] if people.length == 1

    if people.length == 2
      return [[Pair.new(:person_1 => people[0], :person_2 => people[1])]]
    end

    pair_sets = []
    people.combination(2).each do |person_1, person_2|
      pair = Pair.new(:person_1 => person_1, :person_2 => person_2)
      others = self.generate(people - pair.to_a)
      others.each do |rest|
        pair_sets << ([pair] + rest)
      end
    end

    return pair_sets
  end
end
