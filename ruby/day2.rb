# other ways to fill an array with 16 numbers:
# arr = Array.new(16) {|a| a += 1}
# arr = (1..16).to_a
arr = [*(1..16)] 
arr.each do |n|
  p arr[((n - 4)..n)] if n % 4 == 0
end
[1, 2, 3, 4, 5]
[5, 6, 7, 8, 9]
[9, 10, 11, 12, 13]
[13, 14, 15, 16]
=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]

# Enumerable#each_slice
arr.each_slice(4) {|n| p n}
[1, 2, 3, 4]
[5, 6, 7, 8]
[9, 10, 11, 12]
[13, 14, 15, 16]
=> nil

# Enable the Tree class to accept a hash
class Tree
  attr_accessor :node_name, :children

  def initialize(nodes={})
    @node_name = nodes.keys.first
    @children = []
    nodes.each do |key, value|
      @children.push Tree.new({key => value})
    end
  end

  def visit_all(&block)
    visit &block
    children.each {|c| c.visit_all(&block)}
  end

  def visit(&block)
    block.call self
  end
end

# Write a grep that prints the lines of a file having any occurences of a phrase anywhere in that line.

#!/usr/bin/ruby

unless ARGV.length == 2
  puts "Exactly 2 arguments required"
  exit 1
end

pattern = Regexp.new(ARGV[0])

IO.foreach(ARGV[1]).with_index(1) do |line, index|
  puts "#{index}: #{line}" if line =~ pattern
end
