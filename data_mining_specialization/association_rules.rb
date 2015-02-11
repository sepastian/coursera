require 'pp'

transactions = [
  [ :beer, :nuts, :diaper ],
  [ :beer, :coffee, :diaper, :nuts ],
  [ :beer, :diaper, :eggs ],
  [ :beer, :nuts, :eggs, :milk ],
  [ :nuts, :coffee, :diaper, :eggs, :milk ]
]

# Create all item sets.
item_sets = {
  :one => transactions.flatten.uniq,
  :two => transactions.map{ |t| t.combination(2).to_a }.flatten(1).map(&:sort).uniq
}

# Compute support for each item set.
support = item_sets.each do |key,set|
  
end

# Select two-item-sets with minsup = 0.5
minsup = 0.5
n = transactions.size + 0.0
selection = two_item_sets.select{ |items| transactions.select{ |transaction| (items - transaction).empty?  }.size / n >= minsup }

# Compute number of association rules for minconf = 0.5
selection.each { |first, second| transactions.select}
