class Pair < ActiveRecord::Base
  belongs_to :person_1, :class_name => "Person", :foreign_key => "person_1_id"
  belongs_to :person_2, :class_name => "Person", :foreign_key => "person_2_id"

  attr_accessible :person_1, :person_2

  validates_presence_of :person_1

  def to_a
    [self.person_1, self.person_2]
  end

  def to_s
    return "#{self.person_1.name} & #{self.person_2.name}" if person_2
    "#{self.person_1.name}"
  end

  def ==(other_pair)
    (self.person_1 == other_pair.person_1) && (self.person_2 == other_pair.person_2)
  end

  def self.make_pair(person_1, person_2 = nil)
    Pair.new(:person_1 => person_1, :person_2 => person_2)
  end
end
