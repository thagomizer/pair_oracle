class Pair < ActiveRecord::Base
  belongs_to :person_1, :class_name => "Person", :foreign_key => "person_1_id"
  belongs_to :person_2, :class_name => "Person", :foreign_key => "person_2_id"

  attr_accessible :person_1, :person_2

  validates_presence_of :person_1

  def self.generate(ids)
    people = ids.map { |id| Person.find(id) }

    return [[people.sort]] if people.length < 3

    pairs = []
    people.combination(2).each do |pair|
      pair.sort!
      others = self.generate(people - pair)
      others.each do |rest|
        pairs << ([pair] + rest)
      end
    end
    return pairs
  end
end
