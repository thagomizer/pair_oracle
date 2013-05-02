class TotalPairingsScorer
  def self.score(pair_group)
    score = 0
    pair_group.each do |pair|
      score += Pair.where(:person_1_id => pair.person_1_id,
                          :person_2_id => pair.person_2_id).count
    end
    score
  end
end
