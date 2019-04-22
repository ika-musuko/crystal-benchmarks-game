# https://benchmarksgame-team.pages.debian.net/benchmarksgame/performance/binarytrees.html

class TreeNode
  def initialize(@left : TreeNode?, @right : TreeNode?)
  end

  def item_check
    return 1 unless @left
    left = @left.not_nil!
    right = @right.not_nil!
    1 + left.item_check + right.item_check
  end
end

def bottom_up_tree(depth)
  return TreeNode.new(nil, nil) unless depth > 0
  depth -= 1
  TreeNode.new bottom_up_tree(depth), bottom_up_tree(depth)
end

# main
max_depth = (ARGV[0]? || 10).to_i
min_depth = 4
max_depth = min_depth + 2 if min_depth + 2 > max_depth

stretch_depth = max_depth + 1
stretch_tree = bottom_up_tree(stretch_depth)
puts "stretch tree of depth #{stretch_depth}\t check: #{stretch_tree.item_check}"

long_lived_tree = bottom_up_tree(max_depth)

min_depth.step(to: max_depth+1, by: 2) do |depth|
  iterations = 1 << (max_depth - depth + min_depth)
  check = 0
  iterations.times do
    temp_tree = bottom_up_tree(depth)
    check += temp_tree.item_check
  end
  puts "#{iterations}\t trees of depth #{depth}\t check: #{check}"
end

puts "long lived tree of depth #{max_depth}\t check: #{long_lived_tree.item_check}"


