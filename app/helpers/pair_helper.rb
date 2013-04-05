require 'pp'

module PairHelper
  def pp_pair(pairs)
    pairs.each{ |pair| pp pair.class }
#    pairs.map { |pair| pair.map(&:name).join(" & ") }.join(", ")
  end
end
