require 'pp'

transactions = [
  [:beer,:nuts,:diaper],
  [:beer,:coffee,:diaper,:nuts],
  [:beer,:diaper,:eggs],
  [:beer,:nuts,:eggs,:milk],
  [:nuts,:coffee,:diaper,:eggs,:milk]
]

# All items.
all = transactions.flatten.uniq

# All 3-item-sets.
item_sets = all.combination(3).to_a.map(&:sort).uniq

# 3-item-sets occurring in transactions.
candidates = item_sets.select{ |s| transactions.any?{ |t| (s & t).size >= 3 } }

# Support of 3-item-sets.
support = candidates.map{ |c| [ c, transactions.count{ |t| (c - t).empty? }.fdiv(transactions.size) ] }

puts "How many 3-item-sets with minsup s >= 50%%? %d" % [ support.count{ |s| s.last >= 0.5 } ]

