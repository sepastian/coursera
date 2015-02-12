require 'set'
require 'pp'

transactions = [
  [ :beer, :nuts, :diaper ],
  [ :beer, :coffee, :diaper, :nuts ],
  [ :beer, :diaper, :eggs ],
  [ :beer, :nuts, :eggs, :milk ],
  [ :nuts, :coffee, :diaper, :eggs, :milk ]
].map(&:to_set)

max_item_set_length = transactions.map(&:size).max

# Form all possible N-item-sets.
item_sets = (1..max_item_set_length).map do |l|
  transactions.map{ |t| t.to_a.combination(l).map(&:to_set) }
end.flatten.uniq

# Compute support for each n-item-set.
minsup = 0.5
supports = item_sets.map do |item_set|
  [
    item_set,
    transactions.count{ |transaction| item_set.subset? transaction }.fdiv(transactions.size)
  ]
end
supports = Hash[*supports.flatten]

# Select n-item-sets with n > 1 and support >= minsup.
item_sets_minsup = supports.select{ |item_set,support| item_set.size > 1 and support >= minsup }

# Compute nr of association rules with confidence >= minconf
# for selected items.
minconf = 0.5
item_sets_minconf = item_sets_minsup.map do |item_set,support|
  first_item, second_item = item_set.to_a
  support_first_item = supports[ Set.new [first_item] ]
  support_second_item = supports[ Set.new [second_item] ]
  [
    [ [ first_item, second_item ], support_first_item.fdiv(support_second_item) ],
    [ [ second_item, first_item ], support_second_item.fdiv(support_first_item) ],
  ]
end.flatten(1).select{ |item_set,confidence| confidence >= minconf }
